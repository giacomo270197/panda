from compiler.X86Windows32.compiler import X86Windows32Compiler

class Compiler:

    platform = None
    ast = None
    assembly = None

    def __init__(self, platform, ast):
        if platform == "x86Windows32":
            self.platform = platform
            self.ast = ast
            self.assembly = None
        else:
            exit("Platform {} not supported, aborting".format(platform))

    def compile(self):
        if self.platform == "x86Windows32":
            compiler = X86Windows32Compiler(self.ast)
            self.assembly = compiler.compile()
        else:
             exit("Platform {} not supported, aborting".format(self.platform))
    
    def show_assembly(self):
        for instruction in self.assembly:
            print(instruction)