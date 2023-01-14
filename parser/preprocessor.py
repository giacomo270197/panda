import re

class Preprocessor:

    source = None
    heuristics = []

    def __init__(self, source):
        self.source = source
        self.heuristics = [self.implicit_test_statements, self.increment_shorthand, self.decrement_shorthand,
        self.multiplication_shorthand, self.division_shorthand, self.expand_arrays]

    def implicit_test_statements(self):
        r = r'if\([^=]+?\)(\))?'
        self.source = re.sub(r, lambda m: m.group()[:-1] + " == 0)" , self.source)
    
    def increment_shorthand(self):
        r = r'((.)*?)\+=(.)*?;'
        self.source = re.sub(r, lambda m: m.groups()[0] + "=" +  m.groups()[0] + "+" + m.groups()[2] + ";", self.source)

    def decrement_shorthand(self):
        r = r'((.)*?)-=(.)*?;'
        self.source = re.sub(r, lambda m: m.groups()[0] + "=" +  m.groups()[0] + "-" + m.groups()[2] + ";", self.source)

    def multiplication_shorthand(self):
        r = r'((.)*?)\*=(.)*?;'
        self.source = re.sub(r, lambda m: m.groups()[0] + "=" +  m.groups()[0] + "*" + m.groups()[2] + ";", self.source)

    def division_shorthand(self):
        r = r'((.)*?)\/=(.)*?;'
        self.source = re.sub(r, lambda m: m.groups()[0] + "=" + m.groups()[0] + "/" + m.groups()[2] + ";", self.source)

    def expand_arrays(self):
        r = r'(\w+)\[(\d)+\]'
        self.source = re.sub(r, lambda m: " " + m.groups()[0] + " = {" + ("0, ") * (int(m.groups()[1]) - 1) + "0}", self.source)

    def preprocess(self):
        for heuristic in self.heuristics:
            heuristic()
        return self.source