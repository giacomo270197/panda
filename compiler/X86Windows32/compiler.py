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
        # self.assembly = []
        # self.current_if = 0
        # self.current_while = 0
        # self.syscall_defs_num = 2
        # self.syscall_defs = {
        #     "TerminateProcess": 1,
        #     "LoadLibraryA": 2
        # }
        # self.current_type_var_req = False
        # self.current_type_var = None
        # self.loaded_modules = ["kernel32.dll"]
        self.module = None

    class Variables:
        def __init__(self):
            self.parameters = {}
            self.locals = {}

    def analyze_expression(self, expr, builder, variables):
        if isinstance(expr, LiteralExprNode):
            return ir.Constant(type_mappings["int32"], expr.value)
        if isinstance(expr, IdentifierExprNode):
            if expr.value in variables.locals:
                tmp = builder.load(variables.locals[expr.value])
                return tmp
        if isinstance(expr, StatementNode):
            return self.process_statement(expr, builder, variables)

    def process_statement(self, statement, builder, variables):
        if isinstance(statement, ReturnStatementNode):
            builder.ret(self.analyze_expression(statement.expr, builder, variables))
        elif isinstance(statement, DeclarationStatementNode):
            if statement.type == "array":
                actual_type = ir.PointerType(type_mappings[statement.expr.arr_type])
            else:
                actual_type = type_mappings[statement.type]
            ptr = builder.alloca(actual_type)
            variables.locals[statement.identifier.value] = ptr
            try:
                value = self.analyze_expression(statement.expr, builder, variables)
                builder.store(value, ptr)
            except AttributeError:
                pass
        elif isinstance(statement, BinaryOperationNode):
            lhs = self.analyze_expression(statement.left_hand, builder, variables)
            rhs = self.analyze_expression(statement.right_hand, builder, variables)
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
            array_space = builder.alloca(type_mappings[statement.arr_type], len(statement.items))
            if statement.defined:
                for x in range(len(statement.items)):
                    int_ptr = builder.ptrtoint(array_space, type_mappings[statement.arr_type])
                    new_idx = builder.add(int_ptr, ir.Constant(int_ptr.type, x * size_mappings[statement.arr_type]))
                    new_idx_ptr = builder.inttoptr(new_idx, new_idx.as_pointer())
                    builder.store(ir.Constant(type_mappings[statement.arr_type], statement.items[x]), new_idx_ptr)
            return array_space
        else:
            exit()

    def process_block(self, block, function, variables):
        ir_block = function.append_basic_block()
        builder = ir.IRBuilder(ir_block)
        for statement in block.statements:
            self.process_statement(statement, builder, variables)

    def process_function(self, function):
        func_type = function.type
        func_identifier = function.identifier
        func_parameters = function.parameters
        func_body = function.body
        new_func_type = ir.FunctionType(type_mappings[func_type],
                                        [type_mappings[func_parameters[x]] for x in range(len(func_parameters)) if
                                         x % 2 == 0])
        func = ir.Function(self.module, new_func_type, name=func_identifier)
        variables = self.Variables()
        variables.parameters = {x: y for x, y in zip(func_parameters[1::2], func_parameters[::2])}
        self.process_block(func_body, func, variables)

    def create_assembly(self, platform):
        self.module = ir.Module(name="Shellcode")
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
