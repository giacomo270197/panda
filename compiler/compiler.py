from compiler.X86Windows32.compiler import X86Windows32Compiler


class Compiler:
    platform = None
    ast = None
    assembly = None
    compiler = None
    binary_code = None

    def __init__(self, platform, ast):
        if platform == "32":
            self.platform = platform
            self.ast = ast
            self.assembly = None
        else:
            exit("Platform {} not supported, aborting".format(platform))

    def create_assembly(self):
        if self.platform == "32":
            self.compiler = X86Windows32Compiler(self.ast)
            self.assembly = self.compiler.create_assembly(self.platform)
        else:
            exit("Platform {} not supported, aborting".format(self.platform))

    def show_assembly(self):
        for instruction in self.assembly:
            print(instruction)

    def remove_comments(self):
        for x in range(len(self.assembly)):
            line = self.assembly[x].replace(" ", "")
            if line[0] == ";":
                self.assembly[x] = ""

    def compile(self):
        self.remove_comments()
        assembly = "\n".join(self.assembly)
        self.binary_code = self.compiler.compile(assembly)
        return self.binary_code
