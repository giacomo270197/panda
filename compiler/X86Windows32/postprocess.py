import re

class PostProcessor:

    reg_mapping = {
        "eax": "al",
        "ebx": "bl",
        "ecx": "cl",
        "edx": "dl"
    }

    def __init__(self, assembly):
        self.assembly = assembly
        self.rules = [self.remove_memory_to_memory, self.remove_zero_operations]

    def remove_memory_to_memory(self):
        for x in range(len(self.assembly)):
            instruction = self.assembly[x]
            # Case like mov [ebp-0x4], dword ptr.[...]
            matches = [m.start() for m in re.finditer(r'\[ebp[+|-]0x[\w]+?\], (?:dword|byte) ptr \[([a-z]{3})\]', instruction)]
            if matches:
                r = r'((dword|byte) ptr \[([a-z]{3})\])'
                m = re.search(r, instruction)
                to_replace = m.groups()[0]
                target = m.groups()[1]
                register = m.groups()[2]
                instruction = instruction.replace(to_replace, register)
                if target == "byte" and register in list(self.reg_mapping.keys()):
                    new_register = self.reg_mapping[register]
                    instruction = "\n".join([
                        "       mov {}, {} ptr[{}]".format(new_register, target, register),
                        "       movzx {}, {}".format(register, new_register),
                        instruction
                    ])
                else:
                    instruction = "       mov {}, {} ptr[{}]".format(register, target, register) + "\n" + instruction
                self.assembly[x] = instruction
            # Case like mov dword ptr [...], dword ptr [...]
            matches = [m.start() for m in re.finditer(r'(?:dword|byte) ptr \[[\S]+?\], (?:dword|byte) ptr \[([a-z]{3})\]', instruction)]
            if matches:
                r = r'(?:dword|byte) ptr \[[\S]+?\], ((dword|byte) ptr \[([a-z]{3})\])'
                m = re.search(r, instruction)
                to_replace = m.groups()[0]
                target = m.groups()[1]
                register = m.groups()[2]
                instruction = instruction.replace(to_replace, register)
                if target == "byte" and register in list(self.reg_mapping.keys()):
                    new_register = self.reg_mapping[register]
                    instruction = "\n".join([
                        "       mov {}, {} ptr[{}]".format(new_register, target, register),
                        "       movzx {}, {}".format(register, new_register),
                        instruction
                    ])
                else:
                    instruction = "       mov {}, {} ptr[{}]".format(register, target, register) + "\n" + instruction
                self.assembly[x] = instruction
            matches = [m.start() for m in re.finditer(r'mov ([a-z]{3}), byte ptr \[[a-z]{3}\]', instruction)]
            if matches:
                print(instruction)
                m = re.search(r'mov ([a-z]{3}), (byte ptr \[[a-z]{3}\])', instruction)
                register = m.groups()[0]
                source = m.groups()[1]
                try:
                    new_register = self.reg_mapping[register]
                except KeyError:
                    exit("Using a non general purpose register for genral purpose reasons")
                instruction = "\n".join([
                    "       mov {}, {}".format(new_register, source),
                    "       movzx {}, {}".format(register, new_register)
                ])
                self.assembly[x] = instruction

    def remove_zero_operations(self):
        for x in range(len(self.assembly)):
            if "add" in self.assembly[x] or "sub" in self.assembly[x]:
                if self.assembly[x].endswith("0x0"):
                    self.assembly[x] = ""

    def postprocess(self):
        for rule in self.rules:
            rule()
        self.assembly = [x for x in self.assembly if x]
        return self.assembly