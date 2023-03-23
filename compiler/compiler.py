import os
import re
import struct
import subprocess
import keystone as ks

from compiler.assembler import Assembler


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

    def clean_assembly(self, asm):
        new_asm = []
        asm = asm.split("\n")
        for line in asm:
            if not line.replace("\t", "").startswith(".") and not line.replace(" ", "").startswith("#"):
                new_asm.append(line)
        new_asm = "\n".join(new_asm)
        new_asm = re.sub(r'_(main:)', lambda m: m.groups()[0], new_asm)
        return new_asm

    def create_assembly(self):
        self.compiler = Assembler(self.ast)
        self.compiler.create_assembly(self.platform)
        if self.platform == "32":
            subprocess.call(["clang", "-g", "-ooutput.s", "-masm=intel", "-fno-omit-frame-pointer", "-S", "-x", "ir", "-m32", "example.ll"],
                            stdout=subprocess.DEVNULL)
        else:
            subprocess.call(["clang", "-g", "-ooutput.s", "-masm=intel", "-fno-omit-frame-pointer", "-S", "-x", "ir", "example.ll"],
                            stdout=subprocess.DEVNULL)
        path = os.path.join(os.getcwd(), "output.s")
        with open(path) as asm_file:
            asm = asm_file.read()
        asm = self.clean_assembly(asm)
        asm = "jmp main\n" + asm
        self.assembly = asm

    def show_assembly(self):
        print(self.assembly)

    def remove_comments(self):
        for x in range(len(self.assembly)):
            line = self.assembly[x].replace(" ", "")
            if line and line[0] == ";":
                self.assembly[x] = ""

    def compile(self):
        self.remove_comments()
        eng = ks.Ks(ks.KS_ARCH_X86, ks.KS_MODE_32)
        try:
            encoding, _ = eng.asm(self.assembly)
        except ks.KsError as e:
            print("ERROR: %s" % e)
            exit()
        bytecode = b""
        for e in encoding:
            bytecode += struct.pack("B", e)
        packed_code = bytearray(bytecode)
        return packed_code

