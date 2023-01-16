import re

class PostProcessor:
    def __init__(self, assembly):
        self.assembly = assembly
        self.rules = [self.remove_memory_to_memory]

    def remove_memory_to_memory(self):
        for x in range(len(self.assembly)):
            instruction = self.assembly[x]
            # Case like mov [ebp-0x4], dword ptr.[...]
            matches = [m.start() for m in re.finditer(r'\[ebp-0x[\d]+?\], dword ptr \[([a-z]{3})\]', instruction)]
            if matches:
                r = r'(dword ptr \[([a-z]{3})\])'
                to_replace = m.groups()[0]
                m = re.search(r, instruction)
                register = m.groups()[1]
                instruction = instruction.replace(to_replace, register)
                #instruction = re.sub(r, lambda m: m.groups()[1], instruction)
                instruction = "       mov {}, dword ptr[{}]".format(register, register) + "\n" + instruction
                self.assembly[x] = instruction
            # Case like mov dword ptr [...], dword ptr [...]
            matches = [m.start() for m in re.finditer(r'dword ptr \[[\S]+?\], dword ptr \[([a-z]{3})\]', instruction)]
            if matches:
                r = r'dword ptr \[[\S]+?\], (dword ptr \[([a-z]{3})\])'
                m = re.search(r, instruction)
                to_replace = m.groups()[0]
                register = m.groups()[1]
                instruction = instruction.replace(to_replace, register)
                instruction = "       mov {}, dword ptr[{}]".format(register, register) + "\n" + instruction
                self.assembly[x] = instruction

    def postprocess(self):
        for rule in self.rules:
            rule()
        return self.assembly