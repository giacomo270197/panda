import lark
import rich

from .ast_transformer import AstTransformer

class Parser():

    lark_obj = None
    parsed = None
    text = None
    ast = None

    def __init__(self, text):
        grammar_file = open("parser/grammar.lark", "rt")
        grammar_text = grammar_file.read()
        grammar_file.close()
        self.lark_obj = lark.Lark(grammar_text, start="program") #, ambiguity="explicit")
        self.text = text

    def parse(self):
        self.parsed = self.lark_obj.parse(self.text)
    
    def display_parsed(self):
        rich.print(self.parsed)

    def build_ast(self):
        transformer = AstTransformer()
        self.ast = transformer.transform(self.parsed)
    
    def display_ast(self):
        rich.print(self.ast)
