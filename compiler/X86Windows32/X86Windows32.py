class X86Windows32AssemblyBuilder:
    def generate_assembly():
        return

class BinaryOperator:
    pass

class FunctionAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, function_name, num_of_variables):
        num_of_variables *= 4
        assembly = [
            "   {}:".format(function_name),
            "       mov ebp, esp;",
            "       sub esp, {};".format(hex(num_of_variables))
        ]
        return assembly

def to_hex(s):
    retval = list()
    for char in s:
        retval.append(hex(ord(char)).replace("0x", ""))
    return "".join(retval)

class DeclarationStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, num_of_variables, init_value=None):
        current_var = (num_of_variables + 1) * 4
        if init_value and isinstance(init_value, int):
            init_value = hex(int)
        elif init_value and isinstance(init_value, str):
            tmp = init_value[::-1]
            for x in range(0, len(tmp), 4):
                
        assembly = ""
        if init_value:
            assembly = [
                "       mov [ebp-{}], {};".format(hex(current_var), hex(init_value))
            ]
        return assembly

class AssignmentStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, variable_offset, value):
        if isinstance(value, int):
            value = hex(value)
        assembly = [
                "       mov [ebp-{}], {};".format(hex(variable_offset), value)
            ]
        return assembly

class AdditionStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, right_hand):
        assembly = [
            "       add {}, {};".format(left_hand, right_hand)
        ]
        return assembly

class SubtractionStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, right_hand):
        assembly = [
            "       sub {}, {};".format(left_hand, right_hand)
        ]
        return assembly

class MultiplicationStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, right_hand):
        assembly = [
            "       mul {}, {};".format(left_hand, right_hand)
        ]
        return assembly

class ReturnStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, value):
        if value == "eax":
            assembly = [
                "       ret        ;"
            ]
        else:
            assembly = [
                "       mov eax, {};".format(value),
                "       ret        ;"
            ]
        return assembly