from rply import LexerGenerator


class Lexer():
    def __init__(self):
        self.lexer = LexerGenerator()

    def add_functions(self):
        self.lexer.add('PRINT', r'print')  # print

    def add_symbols(self):
        # Operators
        self.lexer.add('SUM', r'\+')
        self.lexer.add('SUB', r'\-')        
        self.lexer.add('MUL', r'\*')
        self.lexer.add('DIV', r'\/')      
        # Parenthesis
        self.lexer.add('OPEN_PAREN', r'\(')
        self.lexer.add('CLOSE_PAREN', r'\)')
        # Number
        self.lexer.add('NUMBER', r'\d+')

    def add_tokens(self):
        self.add_functions()
        self.add_symbols()
        # Ignore spaces
        self.lexer.ignore('\s+')

    def get_lexer(self):
        self._add_tokens()
        return self.lexer.build()