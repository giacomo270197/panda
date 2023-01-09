from compiler.X86Windows32.X86Windows32 import *
from compiler.X86Windows32.mappings import node_to_builder_map
from parser.nodes import *

class X86Windows32Compiler:
    
    def __init__(self, ast):
        self.ast = ast
        self.assembly = []

    class Variables:
        parameters = {}
        variables = {}

        def __init__(self, parameters):
            self.parameters = parameters

    def analyze_expression(self, expr, list_of_variables, state_of_registers):
        if isinstance(expr, LiteralExprNode):
            try:
                return int(expr.value)
            except ValueError:
                return expr.value
        if isinstance(expr, IdentifierExprNode):
            name = expr.value
            if name not in list(list_of_variables.variables.keys()) and name not in list(list_of_variables.parameters.keys()):
                exit("Error: variable {} not declared".format(name))
            for key in state_of_registers.keys():
                if state_of_registers[key][0] == name:
                    return key
            in_params = False
            try:
                idx = (list(list_of_variables.variables.keys()).index(name) + 1) * 4
            except ValueError:
                idx = (list(list_of_variables.parameters.keys()).index(name) + 2) * 4
                in_params = True
            available_register = None
            for key in state_of_registers.keys():
                if state_of_registers[key][1]:
                    available_register = key
                    break
            if in_params:
                self.assembly.append("       mov {}, [ebp+{}];".format(available_register, hex(idx)))
            else:
                self.assembly.append("       mov {}, [ebp-{}];".format(available_register, hex(idx)))
            state_of_registers[available_register][0] = name
            state_of_registers[available_register][1] = False
            return available_register
        if isinstance(expr, StatementNode):
            return self.process_statement(expr, list_of_variables, state_of_registers)

    def process_statement(self, statement, list_of_variables, state_of_registers):
        assembly_builder = node_to_builder_map[type(statement).__name__]()
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
            name = statement.identifier.value
            if name not in list(list_of_variables.variables.keys()) and name not in list(list_of_variables.parameters.keys()):
                exit("Error: variable {} not declared".format(name))
            try:
                idx = (list(list_of_variables.variables.keys()).index(name) + 1) * 4
            except ValueError:
                idx = (list(list_of_variables.parameters.keys()).index(name) + 2) * 4
                in_params = True
            value = self.analyze_expression(statement.expr, list_of_variables, state_of_registers)
            statement_assembly = assembly_builder.generate_assembly(idx, value, in_params)
            for instruction in statement_assembly:
                self.assembly.append(instruction)
        if isinstance(assembly_builder, FunctionCallStatementAssemblyBuilder):
            parameters = []
            for expr in statement.parameters:
                parameters.append(self.analyze_expression(expr, list_of_variables, state_of_registers))
            target = statement.target.value
            statement_assembly = assembly_builder.generate_assembly(parameters, target)
            for instructon in statement_assembly:
                self.assembly.append(instructon)    
            return "eax"
        if isinstance(assembly_builder, ReturnStatementAssemblyBuilder):
            value = self.analyze_expression(statement.expr, list_of_variables, state_of_registers)
            statement_assembly = assembly_builder.generate_assembly(value)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
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
                    return type(operand).__class__
            first_operator_type = get_type(first_operator)
            second_operator_type = get_type(second_operator)
            statement_assembly = assembly_builder.generate_assembly(first_operator, first_operator_type, second_operator, second_operator_type)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            return first_operator
    
    def reset_registers(self, registers):
        for key in registers.keys():
            registers[key][1] = True

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
            "esi": [None, True]
        }
        for statement in statements:
            if isinstance(statement, DeclarationStatementNode):
                num_of_variables += 1
        assembly = FunctionAssemblyBuilder().generate_assembly(function.identifier, num_of_variables)
        self.assembly += assembly
        parameters = {}
        for x in range(0, len(function.parameters), 2):
            parameters[function.parameters[x+1].value] = function.parameters[x]
        list_of_variables = self.Variables({x: parameters[x] for x in list(parameters.keys())[::-1]})
        for statement in statements:
            self.reset_registers(state_of_registers)
            self.process_statement(statement, list_of_variables, state_of_registers)

    def create_preamble(self):
        preamble = [
            "start                    ;",
            "   call main             ;"
        ]
        return preamble

    def compile(self):
        for function in self.ast.func_defs:
            self.process_function(function)
        self.assembly = self.create_preamble() + self.assembly
        return self.assembly