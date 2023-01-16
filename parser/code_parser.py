import lark, rich, re, os

from parser.ast_transformer import AstTransformer
from parser.preprocessor import Preprocessor

class Parser():

    lark_obj = None
    parsed = None
    text = None
    ast = None
    imports = {}
    source_files_queue = []

    def __init__(self, text):
        grammar_file = open("parser/grammar.lark", "rt")
        grammar_text = grammar_file.read()
        grammar_file.close()
        self.lark_obj = lark.Lark(grammar_text, start="program")
        self.text = text
        self.source_files_queue.append(self.text)

    def import_to_path(self, line):
        tmp = line.split(".")
        path = tmp[0]
        for x in tmp[1:]:
            path = os.path.join(path, x)
        path += ".pnd"
        return path

    def resolve_imports(self, source):
        r = r'from ([\w|.]+) import ([\w|,|\s]+)'
        tmp_text = ""
        for line in source.split("\n"):
            m = re.search(r, line)
            if m:
                key = m.groups()[0]
                funcs = set(m.groups()[1].replace(" ", "").split(","))
                if key not in self.imports:
                    with open(self.import_to_path(key)) as f:
                        self.imports[key] = {"func_names": funcs}
                        self.imports[key]["source"] = self.resolve_imports(f.read())
                else:
                    self.imports[key] = {"func_names": funcs.union(self.imports[key]["func_names"])}
            else:
                tmp_text += line + "\n"
        return tmp_text

    def parse(self):
        self.text = Preprocessor(self.text).preprocess()
        self.text = self.resolve_imports(self.text)
        self.parsed = self.lark_obj.parse(self.text)
        for key in self.imports:
            print(self.imports[key]["source"])
            self.imports[key]["parsed"] = self.lark_obj.parse(Preprocessor(self.imports[key]["source"]).preprocess())

    def display_parsed(self):
        rich.print(self.parsed)

    def build_ast(self):
        transformer = AstTransformer()
        self.ast = transformer.transform(self.parsed)
        for key in self.imports:
            self.imports[key]["ast"] = transformer.transform(self.imports[key]["parsed"])
            for func in self.imports[key]["ast"].func_defs:
                if func.identifier in self.imports[key]["func_names"]:
                    self.ast.func_defs.append(func)
    
    def display_ast(self):
        rich.print(self.ast)
