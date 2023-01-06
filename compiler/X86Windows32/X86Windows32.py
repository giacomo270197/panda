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
        assembly = []
        if init_value and isinstance(init_value, int):
            init_value = hex(int)
            assembly.append("       mov [ebp-{}], {};".format(hex(current_var), hex(init_value)))
        elif init_value and isinstance(init_value, str):
            init_value = init_value[1:-1]
            tmp = bytes(init_value, "ascii")
            tmp = tmp + b"\x00" * (4 - (len(tmp) % 4))
            tmp = tmp[::-1]
            for offset in range(0, len(tmp), 4):
                sub_string = "0x" + "".join([hex(x).replace("0x", "") for x in tmp[offset:offset+4]])
                assembly.append("       push {}".format(sub_string))
            assembly.append("       mov [ebp-{}], esp;".format(hex(current_var)))
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
        assembly = []
        if not type(left_hand) == type(right_hand):
            exit("Cannot add operand {} and {}".format(right_hand, left_hand))
        if isinstance(left_hand, int):
            assembly.append("       add {}, {};".format(left_hand, right_hand))
        elif isinstance(left_hand, str):
            exit("String concatenation not implemented yet")
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