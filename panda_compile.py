import argparse
from parser.preprocessor import Preprocessor
from parser.code_parser import Parser
from compiler.compiler import Compiler

def main():

    parser = argparse.ArgumentParser(prog = 'Panda shellcode compiler', description = 'Converts your Panda files to Assembly or machine code')
    parser.add_argument('--source', '-s', type=str, help="The source file")
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
    print(compiler.compile())

if __name__ == "__main__":
    main()
