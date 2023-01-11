import re

class Preprocessor:

    source = None
    heuristics = []

    def __init__(self, source):
        self.source = source
        self.heuristics = [self.implicit_test_statements, self.increment_shorthand, self.decrement_shorthand,
        self.multiplication_shorthand, self.division_shorthand]

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
    
    def preprocess(self):
        for heuristic in self.heuristics:
            heuristic()
        return self.source