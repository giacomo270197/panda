import lark, rich, re, os

from parser.ast_transformer import AstTransformer
from parser.preprocessor import Preprocessor


class Parser:
    lark_obj = None
    parsed = None
    text = None
    ast = None

    def __init__(self, text):
        grammar_file = open("parser/grammar.lark", "rt")
        grammar_text = grammar_file.read()
        grammar_file.close()
        self.lark_obj = lark.Lark(grammar_text, start="program")
        self.text = text
        self.imports = set()
        self.declares = set()

    def resolve_imports(self, source):
        ri = r'import ([\w|\.]+)'
        rd = r'declare ()'
        code = source.split("\n")
        for x in range(len(code)):
            m = re.search(ri, code[x])
            if m and not m.groups()[0] in self.imports:
                self.imports = self.imports.add(m.groups()[0])
                path = os.path.join(*m.groups()[0].split(".")) + ".pnd"
                f = open(path)
                source = f.read()
                f.close()
                source_code = self.resolve_imports(source)
                code[x] = source_code
        return "\n".join(code)

    def parse(self):
        self.text = self.resolve_imports(self.text)
        self.text = Preprocessor(self.text).preprocess()
        self.parsed = self.lark_obj.parse(self.text)

    def display_parsed(self):
        rich.print(self.parsed)

    def build_ast(self):
        transformer = AstTransformer()
        self.ast = transformer.transform(self.parsed)

    def display_ast(self):
        rich.print(self.ast)
