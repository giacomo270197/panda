import argparse, ctypes
from parser.preprocessor import Preprocessor
from parser.code_parser import Parser
from compiler.compiler import Compiler

def main():

    parser = argparse.ArgumentParser(prog = 'Panda shellcode compiler', description = 'Converts your Panda files to Assembly or machine code')
    parser.add_argument('--source', '-s', type=str, help="The source file")
    parser.add_argument('--test', '-t', action='store_true', help="Inject code into the current Python process")
    args = parser.parse_args()
    
    # Parse source code into a list of ASTs
    source = open(args.source)
    text = source.read()
    source.close()
    preprocessor = Preprocessor(text)
    text = preprocessor.preprocess()
    print(text)
    parser = Parser(text)
    parser.parse()
    parser.display_parsed()
    parser.build_ast()
    parser.display_ast()

    # Transform the AST into Assembly
    compiler = Compiler("x86Windows32", parser.ast)
    compiler.create_assembly()
    compiler.show_assembly()
    code = compiler.compile()

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
