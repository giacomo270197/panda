import copy
import keystone as ks
import struct

from compiler.X86Windows32.X86Windows32 import *
from compiler.X86Windows32.mappings import node_to_builder_map, test_to_jmp_instruction
from compiler.X86Windows32.postprocess import PostProcessor
from parser.nodes import *

class X86Windows32Compiler:
    
    def __init__(self, ast):
        self.ast = ast
        self.assembly = []
        self.current_if = 0
        self.current_while = 0
        self.syscall_defs_num = 2
        self.syscall_defs = {}
        self.current_type_var_req = False
        self.current_type_var = None
        self.loaded_modules = ["kernel32.dll"]

    class Variables:
        parameters = {}
        variables = {}

        def __init__(self, parameters):
            self.parameters = parameters

    def find_available_register(self, state_of_registers):
        for key in state_of_registers.keys():
            if state_of_registers[key][1]:
                available_register = key
                break
        return available_register

    def analyze_expression(self, expr, list_of_variables, state_of_registers, pointer=False):
        if isinstance(expr, LiteralExprNode):
            try:
                return int(expr.value)
            except ValueError:
                return expr.value
        if isinstance(expr, IdentifierExprNode):
            name = expr.value
            if name not in list(list_of_variables.variables.keys()) and name not in list(list_of_variables.parameters.keys()):
                exit("Error: variable {} not declared".format(name))
            if pointer:
                try:
                    idx = (list(list_of_variables.variables.keys()).index(name) + 1) * 4
                    in_params = False
                except ValueError:
                    idx = (list(list_of_variables.parameters.keys()).index(name) + 2) * 4
                    in_params = True
                if in_params:
                    return "ebp+{}".format(hex(idx))
                else:
                    return "ebp-{}".format(hex(idx))
            for key in state_of_registers.keys():
                if state_of_registers[key][0] == name:
                    return key
            in_params = False
            if self.current_type_var_req:
                try:
                    self.current_type_var = list_of_variables.variables[name]
                except KeyError:
                    self.current_type_var = list_of_variables.parameters[name]
                self.current_type_var_req = False
            try:
                idx = (list(list_of_variables.variables.keys()).index(name) + 1) * 4
            except ValueError:
                idx = (list(list_of_variables.parameters.keys()).index(name) + 2) * 4
                in_params = True
            available_register = self.find_available_register(state_of_registers)
            if in_params:
                self.assembly.append("       mov {}, [ebp+{}]".format(available_register, hex(idx)))
            else:
                self.assembly.append("       mov {}, [ebp-{}]".format(available_register, hex(idx)))
            state_of_registers[available_register][0] = name
            state_of_registers[available_register][1] = False
            return available_register
        if isinstance(expr, StatementNode):
            return self.process_statement(expr, list_of_variables, state_of_registers)

    def process_statement(self, statement, list_of_variables, state_of_registers):
        assembly_builder = node_to_builder_map[type(statement).__name__]()
        if isinstance(assembly_builder, ArrayNodeAssemblyBuilder):
            items = []
            for item in statement.items:
                if isinstance(item, ExprNode):
                    items.append(self.analyze_expression(item, list_of_variables, state_of_registers))
                else:
                    items.append(item.value)
            statement_assembly = assembly_builder.generate_assembly(items)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            return "esp"            
        if isinstance(assembly_builder, DeclarationStatementAssemblyBuilder):
            value = None
            try:
                if  statement.expr:
                    value = self.analyze_expression(statement.expr, list_of_variables, state_of_registers)
            except AttributeError:
                pass
            statement_assembly = assembly_builder.generate_assembly(len(list_of_variables.variables), statement.type, value)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            list_of_variables.variables[statement.identifier.value] = statement.type
        if isinstance(assembly_builder, AssignmentStatementAssemblyBuilder):
            identifier = statement.identifier
            target = None
            if isinstance(identifier, StatementNode):
                target = self.analyze_expression(identifier, list_of_variables, state_of_registers)
                value = self.analyze_expression(statement.expr, list_of_variables, state_of_registers)    
            else:
                name = statement.identifier.value
                if name not in list(list_of_variables.variables.keys()) and name not in list(list_of_variables.parameters.keys()):
                    exit("Error: variable {} not declared".format(name))
                try:
                    idx = (list(list_of_variables.variables.keys()).index(name) + 1) * 4
                    target = "[ebp-{}]".format(hex(idx))
                except ValueError:
                    idx = (list(list_of_variables.parameters.keys()).index(name) + 2) * 4
                    target = "[ebp+{}]".format(hex(idx))
                value = self.analyze_expression(statement.expr, list_of_variables, state_of_registers)
            statement_assembly = assembly_builder.generate_assembly(target, value)
            for instruction in statement_assembly:
                self.assembly.append(instruction)
        if isinstance(assembly_builder, FunctionCallStatementAssemblyBuilder):
            parameters = []
            for expr in statement.parameters:
                parameters.append(self.analyze_expression(expr, list_of_variables, state_of_registers))
            target = statement.target.value
            syscall_idx = None
            if target in list(self.syscall_defs.keys()):
                syscall_idx = self.syscall_defs[target]
            statement_assembly = assembly_builder.generate_assembly(parameters, target, syscall_idx)
            for instructon in statement_assembly:
                self.assembly.append(instructon)    
            return "eax"
        if isinstance(assembly_builder, ReturnStatementAssemblyBuilder):
            value = self.analyze_expression(statement.expr, list_of_variables, state_of_registers)
            statement_assembly = assembly_builder.generate_assembly(value)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
        if isinstance(assembly_builder, IfStatementAssemblyBuilder):
            self.current_if += 1
            self.process_statement(statement.test, list_of_variables, state_of_registers)
            jmp_intruction = test_to_jmp_instruction[type(statement.test).__name__]
            statement_assembly = assembly_builder.generate_assembly(jmp_intruction, self.current_if)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            self.process_block(statement.if_body, copy.deepcopy(list_of_variables), state_of_registers)
            try:
                self.assembly.append("      jmp if_stmt{}_else".format(str(self.current_if)))
                self.assembly.append("  if_stmt{}:".format(str(self.current_if)))
                self.process_block(statement.else_body, copy.deepcopy(list_of_variables), state_of_registers)
                self.assembly.append("  if_stmt{}_else:".format(str(self.current_if)))
            except AttributeError:
                self.assembly.append("  if_stmt{}:".format(str(self.current_if)))
        if isinstance(assembly_builder, WhileStatementAssemblyBuilder):
            self.current_while += 1
            self.assembly.append("   while_stmt{}:".format(str(self.current_while)))
            self.process_statement(statement.test, list_of_variables, state_of_registers)
            jmp_intruction = test_to_jmp_instruction[type(statement.test).__name__]
            statement_assembly = assembly_builder.generate_assembly(jmp_intruction, self.current_while)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            self.process_block(statement.if_body, copy.deepcopy(list_of_variables), state_of_registers)
            self.assembly.append("       jmp while_stmt{}".format(str(self.current_while))) 
            self.assembly.append("   while_stmt{}_end:".format(str(self.current_while)))     
        if isinstance(assembly_builder, BinaryOperator):
            first_operator = self.analyze_expression(statement.left_hand, list_of_variables, state_of_registers)
            second_operator = self.analyze_expression(statement.right_hand, list_of_variables, state_of_registers)
            first_operator_type = None
            second_operator_type = None
            def get_type(operand):
                if isinstance(operand, str):
                    if operand in state_of_registers.keys():
                        try:
                            return list_of_variables.variables[state_of_registers[operand][0]]
                        except KeyError:
                            return list_of_variables.parameters[state_of_registers[operand][0]]
                    else:
                        return "string"
                else:
                    return type(operand).__name__
            first_operator_type = get_type(first_operator)
            second_operator_type = get_type(second_operator)
            statement_assembly = assembly_builder.generate_assembly(first_operator, first_operator_type, second_operator, second_operator_type)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            return first_operator
        if isinstance(assembly_builder, AddressOfStatementAssemblyBuilder):
            name = statement.operand.value
            in_params = False
            try:
                idx = (list(list_of_variables.variables.keys()).index(name) + 1) * 4
            except ValueError:
                idx = (list(list_of_variables.parameters.keys()).index(name) + 2) * 4
                in_params = True       
            register = self.find_available_register(state_of_registers)
            statement_assembly = assembly_builder.generate_assembly(idx, in_params, register)
            for instructon in statement_assembly:
                self.assembly.append(instructon)                
        if isinstance(assembly_builder, DereferenceStatementAssemblyBuilder):
            operand = statement.operand
            self.current_type_var_req = True
            if isinstance(operand, IdentifierExprNode):
                operand = self.analyze_expression(operand, list_of_variables, state_of_registers, True)
            else:
                operand = self.analyze_expression(operand, list_of_variables, state_of_registers)
            if self.current_type_var == "string":
                return "byte ptr [{}]".format(operand)
            else:
                return "dword ptr [{}]".format(operand)

    def reset_registers(self, registers):
        for key in registers.keys():
            registers[key][0] = None
            registers[key][1] = True

    def process_block(self, block, list_of_variables, state_of_registers):
        statements = block.statements
        for statement in statements:
            self.reset_registers(state_of_registers)
            self.process_statement(statement, list_of_variables, state_of_registers)
        self.reset_registers(state_of_registers)

    def resolve_num_variables(self, body, num_of_variables):
        statements = body.statements
        blocks = []
        for statement in statements:
            if isinstance(statement, DeclarationStatementNode):
                num_of_variables += 1
            if isinstance(statement, IfStatementNode):
                blocks.append(statement.if_body)
                try:
                    blocks.append(statement.else_body)
                except AttributeError:
                    pass
        for block in blocks:
            num_of_variables = self.resolve_num_variables(block, num_of_variables)
        return num_of_variables

            
    def process_function(self, function):
        statements = function.body.statements
        num_of_variables = 0
        list_of_variables = {}
        state_of_registers = {
            "eax": [None, True],
            "ebx": [None, True],
            "ecx": [None, True],
            "edx": [None, True],
            "edi": [None, True],
        }
        num_of_variables = self.resolve_num_variables(function.body, 0)
        assembly = FunctionAssemblyBuilder().generate_assembly(function.identifier, num_of_variables)
        self.assembly += assembly
        parameters = {}
        for x in range(0, len(function.parameters), 2):
            parameters[function.parameters[x+1].value] = function.parameters[x].value
        list_of_variables = self.Variables({x: parameters[x] for x in list(parameters.keys())[::-1]})
        for statement in statements:
            self.reset_registers(state_of_registers)
            self.process_statement(statement, list_of_variables, state_of_registers)

    def ror_str(self, b, count):
        b = "{0:b}".format(b)
        binb = (32 - len(b)) * '0' + b
        while count > 0:
            binb = binb[-1] + binb[0:-1]
            count -= 1
        return (int(binb, 2))

    def push_function_hash(self, function_name):
        edx = 0x00
        ror_count = 0
        for eax in function_name:
            edx = edx + ord(eax)
            if ror_count < len(function_name)-1:
                edx = self.ror_str(edx, 0xd)
            ror_count += 1
        return ("push " + hex(edx))

    def process_syscall(self, syscall, idx):
        if syscall.module_name not in self.loaded_modules:
            statement_assembly = LoadLibraryAssemblyBuilder().generate_assembly(syscall.module_name)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
        key = syscall.function_name.value.replace("\"", "")
        self.syscall_defs[key] = idx
        self.assembly.append("       " + self.push_function_hash(key))
        statement_assembly = FindFunctionPointerAssemblyBuilder().generate_assembly(idx)
        for instructon in statement_assembly:
                self.assembly.append(instructon)

    def create_assembly(self):
        self.assembly.append("start:")
        self.syscall_defs_num += len(self.ast.syscalls)
        if self.syscall_defs_num > 2:
            self.ast.syscalls.sort(key=lambda x: x.module_name)
            statement_assembly = SyscallResolverAssemblyBuilder().generate_assembly(self.syscall_defs_num)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            idx = 0       
            for syscall in self.ast.syscalls:
                idx += 1
                self.process_syscall(syscall, idx)
            self.assembly.append("       mov esi, ebp")
        self.assembly.append("       jmp main")
        for function in self.ast.func_defs:
            self.process_function(function)
        post_process = PostProcessor(self.assembly)
        self.assembly = post_process.postprocess()
        return self.assembly
    
    def compile(self, assembly):
        eng = ks.Ks(ks.KS_ARCH_X86, ks.KS_MODE_32)
        try:
            encoding, _ = eng.asm(assembly)
        except ks.KsError as e:
            print("ERROR: %s" %e)
            exit()
        bytecode = b""
        for e in encoding:
            bytecode += struct.pack("B", e)
        packed_code = bytearray(bytecode)
        return packed_code