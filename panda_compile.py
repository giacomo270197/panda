import argparse
from headers import *
from tokenize import Tokenizer

def main():

    parser = argparse.ArgumentParser(prog = 'Panda shellcode compiler', description = 'Converts your Panda files to Assembly or machine code')
    parser.add_argument('--source', type=str, help="The source file")
    args = parser.parse_args()

    # Create configuration
    config = Config(args.source)
    
    # Tokenize
    source = open(config.source_file)
    text = source.read()
    source.close()
    tokenizer = Tokenizer(text)
    tokenizer.tokenize()
    print(tokenizer.tokens)

if __name__ == "__main__":
    main()