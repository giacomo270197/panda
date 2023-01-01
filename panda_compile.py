import argparse
from lexer import Lexer

def main():

    parser = argparse.ArgumentParser(prog = 'Panda shellcode compiler', description = 'Converts your Panda files to Assembly or machine code')
    parser.add_argument('--source', type=str, help="The source file")
    args = parser.parse_args()
    
    # Tokenize
    source = open(args.source)
    text = source.read()
    source.close()
    lexer = Lexer(text)
    tokens = lexer.tokenize()
    print(tokens)

if __name__ == "__main__":
    main()