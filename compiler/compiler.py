import os
import re
import struct
import subprocess
import keystone as ks
import config

from compiler.assembler import Assembler
from compiler.postprocess import PostProcessor


class Compiler:
    ast = None
    assembly = None
    compiler = None
    binary_code = None

    def __init__(self, ast):
        self.ast = ast
        self.assembly = None

    def clean_assembly(self, asm):
        if config.PLATFORM == "32":
            new_asm = []
            asm = asm.split("\n")
            for line in asm:
                if not line.replace("\t", "").startswith(".") and not line.replace(" ", "").startswith("#"):
                    new_asm.append(line)
            new_asm = "\n".join(new_asm)
            new_asm = re.sub(r'_(main:)', lambda m: m.groups()[0], new_asm)
        elif config.PLATFORM == "64":
            new_asm = []
            asm = asm.split("\n")
            for line in asm:
                if line.startswith(".LBB") or (not line.replace("\t", "").startswith(".") and "__chkstk" not in line):
                    new_asm.append(line)
            new_asm = "\n".join(new_asm)
            new_asm = re.sub(r'#(.*)', lambda m: "", new_asm)
        else:
            exit()
        post_processor = PostProcessor(new_asm)
        new_asm = post_processor.postprocess()
        print(new_asm)
        return new_asm

    def create_assembly(self):
        self.compiler = Assembler(self.ast)
        self.compiler.create_assembly()
        if config.PLATFORM == "32":
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
        if config.PLATFORM == "32":
            eng = ks.Ks(ks.KS_ARCH_X86, ks.KS_MODE_32)
        elif config.PLATFORM == "64":
            eng = ks.Ks(ks.KS_ARCH_X86, ks.KS_MODE_64)
        else:
            exit()
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

