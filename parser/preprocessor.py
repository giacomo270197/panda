import re

class Preprocessor:

    source = None
    heuristics = []

    def __init__(self, source):
        self.source = source
        self.heuristics.append(self.implicit_test_statements)

    def implicit_test_statements(self):
        r = r'if\([^=]+?\)(\))?'
        self.source = re.sub(r, lambda m: m.group()[:-1] + " == 0)" , self.source)
    
    def preprocess(self):
        for heuristic in self.heuristics:
            heuristic()
        return self.source