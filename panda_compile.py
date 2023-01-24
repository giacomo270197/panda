import argparse, ctypes
from parser.preprocessor import Preprocessor
from parser.code_parser import Parser
from compiler.compiler import Compiler


def main():
    parser = argparse.ArgumentParser(prog='Panda shellcode compiler', description='Converts your Panda files to '
                                                                                  'Assembly or machine code')
    parser.add_argument('--source', '-s', type=str, help="The source file")
    parser.add_argument('--test', '-t', action='store_true', help="Inject code into the current Python process")
    parser.add_argument('--asm', '-a', action='store', type=str, help="Output the generate Assembly code in a file")
    parser.add_argument('--bin', '-b', action='store', type=str, help="Output the generate code in a byte file")
    parser.add_argument('--py', '-p', action='store', type=str, help="Output the generate code in a Python byte format")
    parser.add_argument('--debug_asm', '-da', action='store_true', help="Print the assembly")
    parser.add_argument('--debug_tree', '-dt', action='store_true', help="Print the parse tree")
    args = parser.parse_args()

    if not args.source:
        exit("Please select a source file to compile")

    if not args.test and not args.py and not args.bin and not args.asm:
        exit("Please select an output mode")

    # Parse source code into a list of ASTs
    source = open(args.source)
    text = source.read()
    source.close()
    parser = Parser(text)
    parser.parse()
    if args.debug_tree:
        parser.display_parsed()
    parser.build_ast()

    # Transform the AST into Assembly
    compiler = Compiler("x86Windows32", parser.ast)
    compiler.create_assembly()
    if args.debug_asm:
        compiler.show_assembly()
    if args.asm:
        with open(args.asm, "w") as file:
            file.write("\n".join(compiler.assembly))
    code = compiler.compile()
    if args.bin:
        with open(args.bin, "wb") as file:
            file.write(code)
    if args.py:
        out = [("{0:#0{1}x}".format(x, 2)).replace("0x", "\\x") for x in code]
        out = "".join(out)
        with open(args.py, "w") as file:
            file.write(out)

    # Run code in current process
    if args.test:
        ptr = ctypes.windll.kernel32.VirtualAlloc(
            ctypes.c_int(0),
            ctypes.c_int(len(code)),
            ctypes.c_int(0x3000),
            ctypes.c_int(0x40),
        )
        buf = (ctypes.c_char * len(code)).from_buffer(code)
        ctypes.windll.kernel32.RtlMoveMemory(
            ctypes.c_int(ptr), buf, ctypes.c_int(len(code))
        )
        print("[=]   Shellcode located at address %s" % hex(ptr))
        input("...ENTER TO EXECUTE SHELLCODE...")
        ht = ctypes.windll.kernel32.CreateThread(
            ctypes.c_int(0),
            ctypes.c_int(0),
            ctypes.c_int(ptr),
            ctypes.c_int(0),
            ctypes.c_int(0),
            ctypes.pointer(ctypes.c_int(0)),
        )
        ctypes.windll.kernel32.WaitForSingleObject(ctypes.c_int(ht), ctypes.c_int(-1))


if __name__ == "__main__":
    main()
