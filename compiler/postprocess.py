import re

import config


class PostProcessor:
    reg_mapping = {
        "eax": "al",
        "ebx": "bl",
        "ecx": "cl",
        "edx": "dl"
    }

    def __init__(self, assembly):
        self.assembly = assembly.split("\n")
        self.functional_rules = [self.remove_call_functions_preambles_64, self.add_preamble_32]
        self.optimization_rules = []
        self.rules = self.functional_rules + self.optimization_rules

    def lookahead_push_count(self, asm):
        push_count = 0
        for line in asm:
            if "push" in line:
                push_count += 1
            if "ret" in line:
                break
        return push_count

    def remove_call_functions_preambles_64(self):
        if config.PLATFORM == "32":
            return
        new_asm = []
        deletion_mode = False
        need_fixing_epilogue = False
        epilogue_fix = 0
        for line, idx in zip(self.assembly, range(len(self.assembly))):
            if not deletion_mode:
                new_asm.append(line)
                if need_fixing_epilogue and "add" in line:
                    new_asm[-1] = "add     rsp, {}".format(str(epilogue_fix))
                    need_fixing_epilogue = False
                if line.startswith("_call_"):
                    deletion_mode = True
                    need_fixing_epilogue = True
                    push_count = self.lookahead_push_count(self.assembly[idx:])
                    if push_count % 2 == 0:
                        new_asm.append("sub     rsp, 40")
                        epilogue_fix = 40
                    else:
                        new_asm.append("sub     rsp, 32")
                        epilogue_fix = 32
                    if push_count > 3:
                        new_asm.append("mov     rax, qword ptr [rsp + {}]".format(str(8 * (push_count+1) + epilogue_fix)))
                    else:
                        new_asm.append("mov     rax, {}".format(["rcx", "rdx", "r8", "r9"][push_count]))
            elif deletion_mode and "rsi, rsp" in line:
                new_asm.append(line)
                deletion_mode = False
        self.assembly = new_asm

    def add_preamble_32(self):
        if config.PLATFORM == "64":
            return
        new_asm = []
        fixing_mode = False
        for line, idx in zip(self.assembly, range(len(self.assembly))):
            new_asm.append(line)
            if line.startswith("__call_"):
                if "push" not in self.assembly[idx + 1] or "ebp" not in self.assembly[idx + 1]:
                    fixing_mode = True
                    new_asm.append("push ebp")
                    new_asm.append("mov ebp, esp")
            if "ret" in line and fixing_mode:
                new_asm = new_asm[:-1]
                new_asm.append("mov esp, ebp")
                new_asm.append("pop ebp")
                new_asm.append("ret")
                fixing_mode = False
        self.assembly = new_asm

    def postprocess(self):
        for rule in self.rules:
            rule()
        return "\n".join(self.assembly)
