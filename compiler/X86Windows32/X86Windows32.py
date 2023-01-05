class X86Windows32AssemblyBuilder:
    def generate_assembly():
        return

class BinaryOperator:
    pass

class FunctionAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, function_name, num_of_variables):
        assembly = [
            "{}:".format(function_name),
            "mov ebp, esp;",
            "sub esp, {};".format(hex(num_of_variables))
        ]
        return assembly

class DeclarationStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, num_of_variables, init_value=None):
        current_var = (num_of_variables + 1) * 4
        assembly = ""
        if init_value:
            assembly = [
                "mov [ebp+{}], {};".format(hex(current_var), hex(init_value))
            ]
        return assembly

class AssignmentStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, variable_offset, value):
        assembly = [
                "mov [ebp+{}], {};".format(hex(variable_offset), hex(value))
            ]
        return assembly

class AdditionStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, right_hand):
        assembly = [
            "add {}, {};".format(left_hand, right_hand)
        ]
        return assembly

class ReturnStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, value):
        assembly = [
            "mov eax, {};".format(value),
            "ret        ;"
        ]
        return assembly