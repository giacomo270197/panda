from compiler.X86Windows32.X86Windows32 import *
from compiler.X86Windows32.mappings import node_to_builder_map
from parser.nodes import *

class X86Windows32Compiler:
    
    def __init__(self, ast):
        self.ast = ast
        self.assembly = []

    def analyze_expression(self, expr, list_of_variables, state_of_registers):
        if isinstance(expr, LiteralExprNode):
            try:
                return int(expr.value)
            except ValueError:
                return expr.value
        if isinstance(expr, IdentifierExprNode):
            name = expr.value
            if name not in list_of_variables:
                exit("Error: variable {} not declared".format(name))
            for key in state_of_registers.keys():
                if state_of_registers[key][0] == name:
                    return key
            idx = list_of_variables.index(name) * 4
            available_register = None
            for key in state_of_registers.keys():
                if state_of_registers[key][0]:
                    available_register = key
                    break
            self.assembly.append = "mov {}, [ebp+{}];".format(available_register, hex(idx))
            state_of_registers[available_register][0] = name
            state_of_registers[available_register][1] = False
            return available_register
        if isinstance(expr.value, StatementNode):
            return self.process_statement(expr.value)

    def process_statement(self, statement, list_of_variables, state_of_registers):
        print(list_of_variables)
        assembly_builder = node_to_builder_map[type(statement).__name__]()
        if isinstance(assembly_builder, DeclarationStatementAssemblyBuilder):
            value = self.analyze_expression(statement.expr, list_of_variables, state_of_registers)
            statement_assembly = assembly_builder.generate_assembly(len(list_of_variables), value)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            list_of_variables.append(statement.identifier)
        if isinstance(assembly_builder, AssignmentStatementAssemblyBuilder):
            name = statement.identifier
            if not name in list_of_variables:
                exit("Error: variable {} not declared".format(name))
            idx = (list_of_variables.index(name) + 1) * 4
            value = self.analyze_expression(statement.expr)
            statement_assembly = assembly_builder.generate_assembly(idx, value)
        if isinstance(assembly_builder, ReturnStatementAssemblyBuilder):
            value = self.analyze_expression(statement.expr, list_of_variables, state_of_registers)
            statement_assembly = assembly_builder.generate_assembly(value)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            list_of_variables.append(statement.identifier)
        if isinstance(assembly_builder, BinaryOperator):
            first_operator = self.analyze_expression(statement.left_hand, list_of_variables, state_of_registers)
            second_operator = self.analyze_expression(statement.right_hand, list_of_variables, state_of_registers)
            statement_assembly = assembly_builder.generate_assembly(first_operator, second_operator)
            for instructon in statement_assembly:
                self.assembly.append(instructon)
            return first_operator

    def process_function(self, function):
        statements = function.body.statements
        num_of_variables = 0
        list_of_variables = []
        state_of_registers = {
            "eax": (None, True),
            "ebx": (None, True),
            "ecx": (None, True),
            "edx": (None, True),
            "edi": (None, True),
            "esi": (None, True)
        }
        for statement in statements:
            if isinstance(statement, DeclarationStatementNode):
                num_of_variables += 1
                list_of_variables.append(self.analyze_expression(statement.identifier, list_of_variables, state_of_registers))
        assembly = FunctionAssemblyBuilder().generate_assembly(function.identifier, num_of_variables)
        self.assembly += assembly
        for statement in statements:
            self.process_statement(statement, list_of_variables, state_of_registers)

    def compile(self):
        main_func = None
        for function in self.ast.func_defs:
            if function.identifier == "main":
                main_func = function
                self.process_function(function)