import argparse
from parser.code_parser import Parser

def main():

    parser = argparse.ArgumentParser(prog = 'Panda shellcode compiler', description = 'Converts your Panda files to Assembly or machine code')
    parser.add_argument('--source', type=str, help="The source file")
    args = parser.parse_args()
    
    # Parse source code into a list of ASTs
    source = open(args.source)
    text = source.read()
    source.close()
    parser = Parser(text)
    parser.parse()
    parser.display_parsed()
    parser.build_ast()
    parser.display_ast()

if __name__ == "__main__":
    main()
