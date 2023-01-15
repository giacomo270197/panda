class X86Windows32AssemblyBuilder:
    pass

class BinaryOperator(X86Windows32AssemblyBuilder):
    pass

class UnaryOperator(X86Windows32AssemblyBuilder):
    pass

class TestStatement(BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot peform comparison on operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       cmp {}, {};".format(format_int(left_hand), format_int(right_hand)))
        elif left_hand_type == "string":
            exit("Comparison not available for strings")      
        return assembly  


class FunctionAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, function_name, num_of_variables):
        num_of_variables *= 4
        assembly = [
            "   {}:".format(function_name),
            "       push ebp;",
            "       mov ebp, esp;",
            "       sub esp, {};".format(hex(num_of_variables))
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

class ArrayNodeAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, items):
        assembly = []
        for item in items[::-1]:
            try:
                assembly.append("       push {};".format(hex(int(item))))
            except ValueError:
                assembly.append("       push {}".format(item))
        return assembly

class DeclarationStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, num_of_variables, type, init_value=None):
        current_var = (num_of_variables + 1) * 4
        assembly = []
        if init_value != None and type == "int":
            if isinstance(init_value, int):
                init_value = hex(init_value)
            assembly.append("       mov dword ptr [ebp-{}], {};".format(hex(current_var), init_value))
        elif init_value != None and type == "string":
            init_value = init_value[1:-1]
            tmp = bytes(init_value, "ascii")
            tmp = tmp + b"\x00" * (4 - (len(tmp) % 4))
            tmp = tmp[::-1]
            for offset in range(0, len(tmp), 4):
                sub_string = "0x" + "".join([hex(x).replace("0x", "") for x in tmp[offset:offset+4]])
                assembly.append("       push {}".format(sub_string))
            assembly.append("       mov [ebp-{}], esp;".format(hex(current_var)))
        elif init_value and type == "array":
            assembly.append("       mov [ebp-{}], {};".format(hex(current_var), init_value))
        return assembly

class AssignmentStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, target, value):
        assembly = []
        if isinstance(value, int):
            value = hex(value)
        assembly.append("       mov {}, {};".format(target, value))
        return assembly

class AdditionStatementAssemblyBuilder(BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not right_hand_type == "int":
            exit("Cannot add operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       add {}, {};".format(left_hand, right_hand))
        elif left_hand_type == "string":
            exit("String concatenation not implemented yet")
        elif left_hand_type == "array":
            assembly.append("       add {}, {}".format(left_hand, hex(int(right_hand) * 4)))
            #assembly.append("       mov {}, dword ptr [{}]".format(left_hand, left_hand))
        return assembly

class SubtractionStatementAssemblyBuilder(BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot subtract operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       sub {}, {};".format(left_hand, right_hand))
        elif left_hand_type == "string":
            exit("Subtraction not available for strings")
        return assembly

class MultiplicationStatementAssemblyBuilder(BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if right_hand_type != "int":
            exit("Cannot multiply by {}".format(right_hand))
        if left_hand_type == "int":
            assembly.append("       mov ecx, {}".format(format_int(right_hand)))
            assembly.append("       mul ecx;")
        elif left_hand_type == "string":
            exit("String multiplication not implemented yet")
        return assembly

class DivisionStatementAssemblyBuilder(BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if right_hand_type != "int":
            exit("Cannot divide by {}".format(right_hand))
        if left_hand_type == "int":
            assembly.append("       mov ecx, {}".format(format_int(right_hand)))
            assembly.append("       div ecx;")
        elif left_hand_type == "string":
            exit("String multiplication not implemented yet")
        return assembly

class BitwiseAndStatementAssemblyBuilder(BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot peform bitwise AND on operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       and {}, {};".format(left_hand, right_hand))
        elif left_hand_type == "string":
            exit("Bitwise AND not available for strings")
        return assembly

class BitwiseOrStatementAssemblyBuilder(BinaryOperator):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        assembly = []
        if not left_hand_type == right_hand_type:
            exit("Cannot peform bitwise OR on operand {} and {}".format(right_hand, left_hand))
        if left_hand_type == "int":
            assembly.append("       or {}, {};".format(left_hand, right_hand))
        elif left_hand_type == "string":
            exit("Bitwise OR not available for strings")
        return assembly
    
class EqualityStatementAssemblyBuilder(TestStatement):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        return super().generate_assembly(left_hand, left_hand_type, right_hand, right_hand_type)

class GreaterStatementAssemblyBuilder(TestStatement):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        return super().generate_assembly(left_hand, left_hand_type, right_hand, right_hand_type)

class GreaterEqualStatementAssemblyBuilder(TestStatement):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        return super().generate_assembly(left_hand, left_hand_type, right_hand, right_hand_type)    

class LowerStatementAssemblyBuilder(TestStatement):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        return super().generate_assembly(left_hand, left_hand_type, right_hand, right_hand_type)

class LowerEqualStatementAssemblyBuilder(TestStatement):
    def generate_assembly(self, left_hand, left_hand_type, right_hand, right_hand_type):
        return super().generate_assembly(left_hand, left_hand_type, right_hand, right_hand_type) 

class AddressOfStatementAssemblyBuilder(UnaryOperator):
    def generate_assembly(self, offset):
        pass

class DereferenceStatementAssemblyBuilder(UnaryOperator):
    def generate_assembly(self, offset):
        pass

class IfStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, instruction, label):
        assembly = []
        assembly.append("       {} if_stmt{};".format(instruction, str(label)))
        return assembly

class WhileStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, instruction, label):
        assembly = []
        assembly.append("       {} while_stmt{}_end;".format(instruction, str(label)))
        return assembly

class FunctionCallStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, parameters, target, syscall_idx):
        assembly = []
        for param in parameters:
            assembly.append("       push {};".format(param))
        if syscall_idx:
            assembly.append("       call dword ptr [esi+{}]".format(hex(0x14 + (syscall_idx * 4))))
        else:
            assembly.append("       call {};".format(target))
        return assembly

class ReturnStatementAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, value):
        if value == "eax":
            assembly = [
                "       mov esp, ebp;",
                "       pop ebp;",
                "       ret;",
            ]
        else:
            assembly = [
                "       mov eax, {};".format(value),
                "       mov esp, ebp;",
                "       pop ebp;",
                "       ret;",
            ]
        return assembly
    
class SyscallResolverAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, syscall_nums):
        assembly = [
        "       mov ebp, esp;",
        "       sub esp, {};".format(hex(syscall_nums * 4 + 1552)),
        "   find_kernel32:                       ",
        "       xor ecx,ecx                     ;",  # ECX = 0
        "       mov esi,fs:[ecx+30h]            ;",  # ESI = &(PEB) ([FS:0x30])
        "       mov esi,[esi+0Ch]               ;",  # ESI = PEB->Ldr
        "       mov esi,[esi+1Ch]               ;",  # ESI = PEB->Ldr.InInitOrder
        "   next_module:                         ",
        "       mov ebx, [esi+8h]               ;",  # EBX = InInitOrder[X].base_address
        "       mov edi, [esi+20h]              ;",  # EDI = InInitOrder[X].module_name
        "       mov esi, [esi]                  ;",  # ESI = InInitOrder[X].flink (next)
        "       cmp [edi+12*2], cx              ;",  # (unicode) modulename[12] == 0x00?
        "       jne next_module                 ;",  # No: try next module.
        "   find_function_shorten:               ",
        "       jmp find_function_shorten_bnc   ;",  # Short jump
        "   find_function_ret:                   ",
        "       pop esi                         ;",  # POP the return address from the stack
        "       mov [ebp+0x04], esi             ;",  # Save find_function address for later usage
        "       jmp resolve_symbols_kernel32    ;",  #
        "   find_function_shorten_bnc:           ",
        "       call find_function_ret          ;",  # Relative CALL with negative offset
        "   find_function:                       ",
        "       pushad                          ;",  # Save all registers from Base address of kernel32 is in EBX Previous step (find_kernel32)
        "       mov eax, [ebx+0x3c]             ;",  # Offset to PE Signature
        "       mov edi, [ebx+eax+0x78]         ;",  # Export Table Directory RVA
        "       add edi, ebx                    ;",  # Export Table Directory VMA
        "       mov ecx, [edi+0x18]             ;",  # NumberOfNames
        "       mov eax, [edi+0x20]             ;",  # AddressOfNames RVA
        "       add eax, ebx                    ;",  # AddressOfNames VMA
        "       mov [ebp-4], eax                ;",  # Save AddressOfNames VMA for later
        "   find_function_loop:                  ",
        "       jecxz find_function_finished    ;",  # Jump to the end if ECX is 0
        "       dec ecx                         ;",  # Decrement our names counter
        "       mov eax, [ebp-4]                ;",  # Restore AddressOfNames VMA
        "       mov esi, [eax+ecx*4]            ;",  # Get the RVA of the symbol name
        "       add esi, ebx                    ;",  # Set ESI to the VMA of the current
        "   compute_hash:                        ",
        "       xor eax, eax                    ;",  # NULL EAX
        "       cdq                             ;",  # NULL EDX
        "       cld                             ;",  # Clear direction
        "   compute_hash_again:                  ",
        "       lodsb                           ;",  # Load the next byte from esi into al
        "       test al, al                     ;",  # Check for NULL terminator
        "       jz compute_hash_finished        ;",  # If the ZF is set, we've hit the NULL term
        "       ror edx, 0x0d                   ;",  # Rotate edx 13 bits to the right
        "       add edx, eax                    ;",  # Add the new byte to the accumulator
        "       jmp compute_hash_again          ;",  # Next iteration
        "   compute_hash_finished:               ",
        "   find_function_compare:               ",
        "       cmp edx, [esp+0x24]             ;",  # Compare the computed hash with the requested hash
        "       jnz find_function_loop          ;",  # If it doesn't match go back to find_function_loop
        "       mov edx, [edi+0x24]             ;",  # AddressOfNameOrdinals RVA
        "       add edx, ebx                    ;",  # AddressOfNameOrdinals VMA
        "       mov cx, [edx+2*ecx]             ;",  # Extrapolate the function's ordinal
        "       mov edx, [edi+0x1c]             ;",  # AddressOfFunctions RVA
        "       add edx, ebx                    ;",  # AddressOfFunctions VMA
        "       mov eax, [edx+4*ecx]            ;",  # Get the function RVA
        "       add eax, ebx                    ;",  # Get the function VMA
        "       mov [esp+0x1c], eax             ;",  # Overwrite stack version of eax from pushad
        "   find_function_finished:              ",
        "       popad                           ;",  # Restore registers
        "       ret                             ;",  #
        "   resolve_symbols_kernel32:            ",
        "       push 0x78b5b983;",                   # TerminateProcess hash
        "       call dword ptr [ebp+0x04]       ;",  # Call find_function
        "       mov [ebp+0x10], eax             ;",  # Save TerminateProcess address for later
        "       push 0xec0e4e8e;",                # LoadLibraryA hash
        "       call dword ptr [ebp+0x04]       ;",  # Call find_function
        "       mov [ebp+0x14], eax             ;",  # Save TerminateProcess address for later
        ]
        return assembly

class LoadLibraryAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, module_name):
        assembly = []
        module_name = module_name[1:-1]
        tmp = bytes(module_name, "ascii")
        tmp = tmp + b"\x00" * (4 - (len(tmp) % 4))
        tmp = tmp[::-1]
        for offset in range(0, len(tmp), 4):
            sub_string = "0x" + "".join([hex(x).replace("0x", "") for x in tmp[offset:offset+4]])
            assembly.append("       push {}".format(sub_string))
        assembly.append("       push esp;")
        assembly.append("       call dword ptr [ebp+0x14]")
        assembly.append("       mov ebx, eax")
        return assembly

class FindFunctionPointerAssemblyBuilder(X86Windows32AssemblyBuilder):
    def generate_assembly(self, idx):
        assembly = [
            "       call dword ptr [ebp+0x04];",
            "       mov [ebp+{}], eax".format(hex(0x14 + (idx*4)))
        ]
        return assembly