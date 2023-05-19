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
        self.sources = []

    def find_imported_libraries(self, code):
        ri = r'import ([\w|\.]+)'
        for line in code:
            m = re.search(ri, line)
            if m:
                imp = m.groups()[0].replace(" ", "").replace("\n", "")
                path = os.path.join(*imp.split(".")) + ".pnd"
                self.imports.add(path)
                f = open(path)
                source = f.read()
                f.close()
                self.find_imported_libraries(source.split("\n"))

    def find_syscall_declarations(self, code):
        rd = r'(declare(.*?;))'
        for line in code:
            m = re.search(rd, line)
            if m:
                self.declares.add(m.groups()[0])

    def resolve_imports(self, source):
        new_code = []
        code = source.split("\n")
        self.find_imported_libraries(code)
        self.find_syscall_declarations(code)
        for library in self.imports:
            with open(library) as f:
                imp_source = f.read()
                imp_source = imp_source.split("\n")
                self.sources.append(imp_source)
                self.find_syscall_declarations(imp_source)
        self.sources.append(code)
        for s in self.sources:
            for line in s:
                if not line.lstrip().startswith("import") and not line.lstrip().startswith("declare"):
                    new_code.append(line)
        new_code = list(self.declares) + new_code
        return "\n".join(new_code)

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
