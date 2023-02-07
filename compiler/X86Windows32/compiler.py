import os
import struct
import subprocess
import re

import keystone as ks
from llvmlite import ir

from compiler.X86Windows32.mappings import type_mappings, size_mappings, test_instructions, register_size_mapping
from parser.nodes import *


class X86Windows32Compiler:

    def __init__(self, ast):
        self.ast = ast
        self.module = None
        self.functions = {}
        self.loops = 0
        self.ifs = 0

    class Variable:
        def __init__(self, ptr, value, var_type):
            self.ptr = ptr
            self.value = value
            self.type = var_type

    class Variables:
        def __init__(self):
            self.parameters = {}
            self.locals = {}

    def zext_to_highest(self, a, b, builder):
        size1 = size_mappings[str(a.type)]
        size2 = size_mappings[str(b.type)]
        if size1 == size2:
            return a, b
        elif size1 > size2:
            b = builder.zext(b, a.type)
            return a, b
        else:
            a = builder.zext(a, b.type)
            return a, b

    def analyze_expression(self, expr, builder, variables, **kwargs):
        if isinstance(expr, LiteralExprNode):
            if "preferred_type" in kwargs:
                return ir.Constant(kwargs["preferred_type"], expr.value)
            return ir.Constant(ir.IntType(64), expr.value)
        if isinstance(expr, IdentifierExprNode) and "as_ptr" in kwargs:
            return variables.locals[expr.value].ptr
        elif isinstance(expr, IdentifierExprNode) and isinstance(variables.locals[expr.value].type, ir.ArrayType):
            return builder.bitcast(variables.locals[expr.value].ptr, ir.PointerType(variables.locals[expr.value].type.element))
        elif isinstance(expr, IdentifierExprNode):
            ret = builder.load(variables.locals[expr.value].ptr)
            return ret
        if isinstance(expr, StatementNode):
            if isinstance(expr, IndexingStatementNode):
                operand = self.analyze_expression(expr.operand, builder, variables, as_ptr=True)
                idx = self.analyze_expression(expr.index, builder, variables)
                first = ir.Constant(ir.IntType(8), 0)
                tmp = builder.gep(operand, [first, idx], inbounds=True)
                if "as_ptr" not in kwargs:
                    tmp = builder.load(tmp)
                return tmp
            elif isinstance(expr, AddressOfStatement):
                return variables.locals[expr.operand.value].ptr
            else:
                if "preferred_type" in kwargs:
                    expr.preferred_type = kwargs["preferred_type"]
                return self.process_statement(expr, builder, variables)

    def process_statement(self, statement, builder, variables):
        if isinstance(statement, ReturnStatementNode):
            builder.ret(self.analyze_expression(statement.expr, builder, variables,
                                                preferred_type=builder.function.type.pointee.return_type))
        elif isinstance(statement, DeclarationStatementNode):
            if statement.type == "array":
                value = self.analyze_expression(statement.expr, builder, variables)
                variables.locals[statement.identifier.value] = value
            else:
                actual_type = type_mappings[statement.type]
                ptr = builder.alloca(actual_type, name=statement.identifier.value)
                variables.locals[statement.identifier.value] = self.Variable(ptr, None, actual_type)
                if statement.expr:
                    new_statement = AssignmentStatementNode(statement.identifier, statement.expr)
                    self.process_statement(new_statement, builder, variables)
                else:
                    variables.locals[statement.identifier.value].value = actual_type(0)
        elif isinstance(statement, AssignmentStatementNode):
            identifier = self.analyze_expression(statement.identifier, builder, variables, as_ptr=True)
            actual_type = identifier.type.pointee
            value = self.analyze_expression(statement.expr, builder, variables, preferred_type=actual_type)
            if isinstance(value.type, ir.PointerType):
                builder.store(value, identifier)
            else:
                if size_mappings[str(value.type)] > size_mappings[str(actual_type)]:
                    value = builder.trunc(value, actual_type)
                elif size_mappings[str(value.type)] < size_mappings[str(actual_type)]:
                    value = builder.zext(value, actual_type)
            builder.store(value, identifier)
        elif isinstance(statement, ComparisonStatementNode):
            sign = test_instructions[statement.__class__.__name__]
            lhs = self.analyze_expression(statement.left_hand, builder, variables)
            rhs = self.analyze_expression(statement.right_hand, builder, variables)
            return builder.icmp_unsigned(sign, lhs, rhs)
        elif isinstance(statement, BinaryOperationNode):
            lhs = self.analyze_expression(statement.left_hand, builder, variables)
            rhs = self.analyze_expression(statement.right_hand, builder, variables)
            if isinstance(lhs.type, ir.PointerType):
                lhs = builder.ptrtoint(lhs, lhs.type.pointee)
            if isinstance(rhs.type, ir.PointerType):
                rhs = builder.ptrtoint(rhs, rhs.type.pointee)
            lhs, rhs = self.zext_to_highest(lhs, rhs, builder)
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
                tmp = builder.ashr(lhs, rhs)
            return tmp
        elif isinstance(statement, UnaryOperationNode):
            operand = self.analyze_expression(statement.operand, builder, variables)
            tmp = None
            if isinstance(statement, NegateStatementNode):
                tmp = builder.neg(operand)
            elif isinstance(statement, DereferenceStatementNode):
                if not isinstance(operand.type, ir.PointerType):
                    try:
                        assignment_type = getattr(statement, "preferred_type")
                        operand = builder.inttoptr(operand, ir.PointerType(assignment_type))
                    except AttributeError:
                        operand = builder.inttoptr(operand, ir.PointerType(operand.type))
                tmp = builder.load(operand)
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
            return self.Variable(arr, new_arr, arr_type)
        elif isinstance(statement, FunctionCallStatementNode):
            func = self.functions[statement.target.value]
            params = []
            for x, y in zip(statement.parameters, func.args):
                if x.value in variables.locals and isinstance(variables.locals[x.value].type, ir.ArrayType):
                    value = self.analyze_expression(x, builder, variables, as_ptr=True)
                    idx = ir.Constant(ir.IntType(8), 0)
                    value = builder.gep(value, [idx, idx])
                else:
                    value = self.analyze_expression(x, builder, variables, preferred_type=y.type)
                params.append(value)
            ret = builder.call(func, params)
            return ret
        elif isinstance(statement, IfStatementNode):
            test = self.analyze_expression(statement.test, builder, variables)
            with builder.if_else(test) as (then, otherwise):
                with then:
                    self.process_branch_block(statement.if_body, builder, variables)
                with otherwise:
                    if statement.else_body:
                        self.process_branch_block(statement.else_body, builder, variables)
        elif isinstance(statement, WhileStatementNode):
            self.loops += 1
            loop = builder.append_basic_block("loop_{}".format(str(self.loops)))
            after = builder.append_basic_block("loop_after_{}".format(str(self.loops)))
            builder.cbranch(self.analyze_expression(statement.test, builder, variables), loop, after)
            builder.position_at_start(loop)
            self.process_branch_block(statement.body, builder, variables)
            builder.cbranch(self.analyze_expression(statement.test, builder, variables), loop, after)
            builder.position_at_start(after)
        elif isinstance(statement, AsmStatementNode):
            for var, reg in statement.input_mapping.items():
                val = self.analyze_expression(var, builder, variables)
                if isinstance(val.type, ir.PointerType):
                    size = register_size_mapping[reg]
                    val = builder.ptrtoint(val, ir.IntType(size))
                builder.store_reg(val, ir.IntType(register_size_mapping[reg]), reg)
            fty = ir.FunctionType(ir.VoidType(), [])
            builder.asm(fty, statement.assembly.replace("\"", ""), "", [], False)
            for reg, val in statement.output_mapping.items():
                tmp = builder.load_reg(ir.IntType(register_size_mapping[reg]), reg)
                ptr = self.analyze_expression(val, builder, variables, as_ptr=True)
                builder.store(tmp, ptr)
        else:
            exit("Node handling not implemented for {}".format(statement.__class__.__name__))

    def process_branch_block(self, block, builder, variables):
        for statement in block.statements:
            self.process_statement(statement, builder, variables)

    def process_block(self, block, function, variables):
        ir_block = function.append_basic_block()
        builder = ir.IRBuilder(ir_block)
        for name, value in variables.parameters.items():
            ptr = builder.alloca(value.type)
            var = self.Variable(ptr, value, value.type)
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

    def clean_assembly(self, asm):
        new_asm = []
        asm = asm.split("\n")
        for line in asm:
            if not line.replace("\t", "").startswith(".") and not line.replace(" ", "").startswith("#"):
                new_asm.append(line)
        new_asm = "\n".join(new_asm)
        new_asm = re.sub(r'_(main:)', lambda m: m.groups()[0], new_asm)
        return new_asm

    def create_assembly(self, platform):
        self.module = ir.Module(name="Shellcode")
        for function in self.ast.func_defs:
            self.define_funcs(function)
        for function in self.ast.func_defs:
            self.process_function(function)
        with open("example.ll", "w") as f:
            f.write(str(self.module))
        subprocess.call(["clang", "-g", "-ooutput.s", "-masm=intel", "-S", "-x", "ir", "-m32", "example.ll"],
                        stdout=subprocess.DEVNULL
                        )
        path = os.path.join(os.getcwd(), "output.s")
        with open(path) as asm_file:
            asm = asm_file.read()
        asm = self.clean_assembly(asm)
        asm = "jmp main\n" + asm
        return asm

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
