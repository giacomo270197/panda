import copy
import keystone as ks
import struct
from llvmlite import ir

from compiler.X86Windows32.mappings import type_mappings, size_mappings
from compiler.X86Windows32.postprocess import PostProcessor
from parser.nodes import *


class X86Windows32Compiler:

    def __init__(self, ast):
        self.ast = ast
        self.module = None
        self.functions = {}

    class Variable:
        def __init__(self, ptr, value):
            self.ptr = ptr
            self.value = value

    class Variables:
        def __init__(self):
            self.parameters = {}
            self.locals = {}

    def trunc_to_lowest(self, a, b, builder):
        size1 = size_mappings[str(a.type)]
        size2 = size_mappings[str(b.type)]
        if size1 == size2:
            return a, b
        elif size1 > size2:
            a = builder.trunc(a, b.type)
            return a, b
        else:
            b = builder.trunc(b, a.type)
            return a, b

    def analyze_expression(self, expr, builder, variables, **kwargs):
        if isinstance(expr, LiteralExprNode):
            return ir.Constant(type_mappings["int64"], expr.value)
        if isinstance(expr, IdentifierExprNode) and "as_ptr" in kwargs:
            print(variables.locals)
            return variables.locals[expr.value].ptr
        elif isinstance(expr, IdentifierExprNode):
            return variables.locals[expr.value].value
        if isinstance(expr, StatementNode):
            if isinstance(expr, IndexingStatementNode):
                operand = self.analyze_expression(expr.operand, builder, variables, as_ptr=True)
                idx = self.analyze_expression(expr.index, builder, variables)
                first = ir.Constant(ir.IntType(8), 0)
                tmp = builder.gep(operand, [first, idx], inbounds=True)
                if "as_ptr" not in kwargs:
                    tmp = builder.load(tmp)
                return tmp
            else:
                return self.process_statement(expr, builder, variables)

    def process_statement(self, statement, builder, variables):
        if isinstance(statement, ReturnStatementNode):
            builder.ret(self.analyze_expression(statement.expr, builder, variables))
        elif isinstance(statement, DeclarationStatementNode):
            if statement.type == "array":
                value = self.analyze_expression(statement.expr, builder, variables)
                variables.locals[statement.identifier.value] = value
            else:
                actual_type = type_mappings[statement.type]
                ptr = builder.alloca(actual_type)
                variables.locals[statement.identifier.value] = self.Variable(ptr, None)
                try:
                    value = self.analyze_expression(statement.expr, builder, variables)
                    if size_mappings[str(value.type)] > size_mappings[str(actual_type)]:
                        value = builder.trunc(value, actual_type)
                    elif size_mappings[str(value.type)] < size_mappings[str(actual_type)]:
                        value = value.zext(value, actual_type)
                    builder.store(value, ptr)
                    variables.locals[statement.identifier.value].value = value
                except AttributeError:
                    pass
        elif isinstance(statement, AssignmentStatementNode):
            identifier = self.analyze_expression(statement.identifier, builder, variables, as_ptr=True)
            value = self.analyze_expression(statement.expr, builder, variables)
            variables.locals[statement.identifier.value].value = value
            builder.store(value, identifier)
        elif isinstance(statement, BinaryOperationNode):
            lhs = self.analyze_expression(statement.left_hand, builder, variables)
            rhs = self.analyze_expression(statement.right_hand, builder, variables)
            lhs, rhs = self.trunc_to_lowest(lhs, rhs, builder)
            tmp = None
            if isinstance(statement, AdditionStatementNode):
                tmp = builder.add(lhs, rhs)
            elif isinstance(statement, SubtractionStatementNode):
                tmp = builder.sub(lhs, rhs)
            elif isinstance(statement, MultiplicationStatementNode):
                tmp = builder.mul(lhs, rhs)
            elif isinstance(statement, DivisionStatementNode):
                tmp = builder.udiv(lhs, rhs)
            elif isinstance(statement, BitwiseAndStatementNode):
                tmp = builder.and_(lhs, rhs)
            elif isinstance(statement, BitwiseOrStatementNode):
                tmp = builder.or_(lhs, rhs)
            elif isinstance(statement, BitwiseXorStatementNode):
                tmp = builder.xor(lhs, rhs)
            elif isinstance(statement, ShlStatementNode):
                tmp = builder.shl(lhs, rhs)
            elif isinstance(statement, ShrStatementNode):
                tmp = builder.shr(lhs, rhs)
            return tmp
        elif isinstance(statement, UnaryOperationNode):
            operand = self.analyze_expression(statement.operand, builder, variables)
            tmp = None
            if isinstance(statement, NegateStatementNode):
                tmp = builder.neg(operand)
            elif isinstance(statement, DereferenceStatementNode):
                tmp = builder.load(operand)
            elif isinstance(statement, AddressOfStatement):
                tmp = builder.ptrtoint(operand, operand.as_pointer())
            return tmp
        elif isinstance(statement, ArrayNode):
            arr_type = ir.ArrayType(type_mappings[statement.arr_type], len(statement.items))
            arr = builder.alloca(arr_type)
            new_arr = ir.Constant(arr_type, None)
            builder.store(new_arr, arr)
            if statement.defined:
                for x, y in zip(statement.items, range(len(statement.items))):
                    val = ir.Constant(type_mappings[statement.arr_type], x)
                    first = ir.Constant(type_mappings[statement.arr_type], 0)
                    idx = ir.Constant(type_mappings[statement.arr_type], y)
                    elem_ptr = builder.gep(arr, [first, idx], inbounds=True)
                    builder.store(val, elem_ptr)
            return self.Variable(arr, new_arr)
        elif isinstance(statement, FunctionCallStatementNode):
            func = self.functions[statement.target.value]
            params = []
            for x in statement.parameters:
                params.append(self.analyze_expression(x, builder, variables))
            ret = builder.call(func, params)
            return ret
        else:
            exit("Node handling not implemented for {}".format(statement.__class__.__name__))

    def process_block(self, block, function, variables):
        ir_block = function.append_basic_block()
        builder = ir.IRBuilder(ir_block)
        for name, value in variables.parameters.items():
            ptr = builder.alloca(value.type)
            var = self.Variable(ptr, value)
            variables.locals[name] = var
            builder.store(value, ptr)
        for statement in block.statements:
            self.process_statement(statement, builder, variables)

    def process_function(self, function):
        func_body = function.body
        func_identifier = function.identifier
        variables = self.Variables()
        param_names = [function.parameters[x].value for x in range(len(function.parameters)) if x % 2 != 0]
        func = self.functions[func_identifier]
        for param, name in zip(func.args, param_names):
            variables.parameters[name] = param
        self.process_block(func_body, func, variables)

    def define_funcs(self, function):
        func_type = function.type
        func_identifier = function.identifier
        func_parameters = function.parameters
        new_func_type = ir.FunctionType(type_mappings[func_type],
                                        [type_mappings[func_parameters[x]] for x in range(len(func_parameters)) if
                                         x % 2 == 0])
        func = ir.Function(self.module, new_func_type, name=func_identifier)
        self.functions[func_identifier] = func

    def create_assembly(self, platform):
        self.module = ir.Module(name="Shellcode")
        for function in self.ast.func_defs:
            self.define_funcs(function)
        for function in self.ast.func_defs:
            self.process_function(function)
        with open("example.ll", "w") as f:
            f.write(str(self.module))
        return

    def compile(self, assembly):
        eng = ks.Ks(ks.KS_ARCH_X86, ks.KS_MODE_32)
        try:
            encoding, _ = eng.asm(assembly)
        except ks.KsError as e:
            print("ERROR: %s" % e)
            exit()
        bytecode = b""
        for e in encoding:
            bytecode += struct.pack("B", e)
        packed_code = bytearray(bytecode)
        return packed_code
