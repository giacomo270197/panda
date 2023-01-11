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
            "       push ebp        ;",
            "       mov ebp, esp    ;",
            "       sub esp, {}     ;".format(hex(num_of_variables))
        ]
        return assembly

def to_hex(s):
    retval = list()
    for char in s:
        retval.append(hex(ord(char)).replace("0x", ""))
    return "".join(retval)

def format_int(num):
    try:
        return hex(int(num))
    except ValueError:
        return num

class DeclarationStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, num_of_variables, type, init_value=None):
        current_var = (num_of_variables + 1) * 4
        assembly = []
        if init_value and type == "int":
            if isinstance(init_value, int):
                init_value = hex(init_value)
            assembly.append("       mov [ebp-{}], {};".format(hex(current_var), init_value))
        elif init_value and type == "string":
            init_value = init_value[1:-1]
            tmp = bytes(init_value, "ascii")
            tmp = tmp + b"\x00" * (4 - (len(tmp) % 4))
            tmp = tmp[::-1]
            for offset in range(0, len(tmp), 4):
                sub_string = "0x" + "".join([hex(x).replace("0x", "") for x in tmp[offset:offset+4]])
                assembly.append("       push {}".format(sub_string))
            assembly.append("       mov [ebp-{}], esp       ;".format(hex(current_var)))
        return assembly

class AssignmentStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, variable_offset, value, in_params):
        assembly = []
        if isinstance(value, int):
            value = hex(value)
        if in_params:
            assembly.append("       mov [ebp+{}], {}        ;".format(hex(variable_offset), value))
        else:
            assembly.append("       mov [ebp-{}], {}        ;".format(hex(variable_offset), value))
        return assembly

class AdditionStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot add operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       add {}, {}      ;".format(left_hand, right_hand))
        elif left_hand_type == "string":
            exit("String concatenation not implemented yet")
        return assembly

class SubtractionStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot subtract operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       sub {}, {}      ;".format(left_hand, right_hand))
        elif left_hand_type == "string":
            exit("Subtraction not available for strings")
        return assembly

class MultiplicationStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if right_hand_type != "int":
            exit("Cannot multiply by {}".format(right_hand))
        if left_hand_type == "int":
            pass
        elif left_hand_type == "string":
            exit("String multiplication not implemented yet")
        return assembly

class DivisionStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        return assembly

class BitwiseAndStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot peform bitwise AND on operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       and {}, {}      ;".format(left_hand, right_hand))
        elif left_hand_type == "string":
            exit("Bitwise AND not available for strings")
        return assembly

class BitwiseOrStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot peform bitwise OR on operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       or {}, {}       ;".format(left_hand, right_hand))
        elif left_hand_type == "string":
            exit("Bitwise OR not available for strings")
        return assembly
    
class EqualityStatementAssemblyBuilder(X86Windows32AssemblyBuilder, BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        print(left_hand, left_hand_type, right_hand, right_hand_type)
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot peform comparison on operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       cmp {}, {}       ;".format(format_int(left_hand), format_int(right_hand)))
        elif left_hand_type == "string":
            exit("Comparison not available for strings")      
        return assembly  

class IfStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, instruction, label):
        assembly = []
        assembly.append("       {} if_stmt{}       ;".format(instruction, str(label)))
        return assembly

class FunctionCallStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, parameters, target):
        assembly = []
        for param in parameters:
            assembly.append("       push {}     ;".format(param))
        assembly.append("       call {}     ;".format(target))
        return assembly

class ReturnStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, value):
        if value == "eax":
            assembly = [
                "       mov esp, ebp    ;",
                "       pop ebp         ;",
                "       ret             ;",
            ]
        else:
            assembly = [
                "       mov eax, {}     ;".format(value),
                "       mov esp, ebp    ;",
                "       pop ebp         ;",
                "       ret             ;",
            ]
        return assembly