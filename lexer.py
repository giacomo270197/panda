import re

class Lexer():

    operators = ["+", "-", "*", "/", "=", "(", ")", ":", "{", "}", "\"", "'"]
    keywords = ["var", "if", "else", "print"]
    text = ""

    def __init__(self, text):
        self.text = text
    
    def find_tokens_in_line(self, line):
        """
        A function that extracts the token on each line, marked by a ; (semicolon)
        """
        tokens = []
        acc = ""
        for x in line:
            if x in self.operators:
                if acc:
                    tokens.append(acc)
                tokens.append(x)
                acc = ""
            else:
                acc += x
                if acc in self.keywords:
                    tokens.append(acc)
                    acc = ""
        tokens.append(acc)
        tokens = [x.replace(" ", "") for x in tokens]
        return tokens

    def token_post_process_strings(line):
        

    def token_post_process_blocks(self, tokens):
        """
        Some constructs span multiple line delimiters, this functions groups them back together.
        """
        new_tokens = []
        current_line = []
        block_open = 0
        for t in tokens:
            if "{" in t:
                block_open += 1
            if "}" in t:
                block_open -= 1
            current_line += t
            if block_open == 0:
                new_tokens.append(current_line)
                current_line = []
        if block_open != 0:
            exit("Mismatching curly brackets")
        return new_tokens
            
    def tokenize(self):
        """
        The only function that should be called from the outside. It returns the tokens generated from the parsing of the source code.
        """
        tokens = []
        text = self.text.replace("\r", "").replace("\n", "")
        lines = text.split(";")
        for l in lines:
            tokens.append(self.find_tokens_in_line(l))
        tokens = self.token_post_process_blocks(tokens)
        return tokens
