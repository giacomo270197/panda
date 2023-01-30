import re

class Preprocessor:

    source = None
    heuristics = []

    def __init__(self, source):
        self.source = source
        self.rules = [self.increment_shorthand, self.decrement_shorthand, self.multiplication_shorthand,
                      self.division_shorthand, self.expand_arrays, self.expand_strings, self.hex_repr, self.resolve_ip]

    # def implicit_test_statements(self):
    #     r = r'if\([^=]+?\)(\))?'
    #     self.source = re.sub(r, lambda m: m.group()[:-1] + " != 0)" , self.source)
    
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
        r = r'array\s(\w+)+?\s(int|byte)\[(\d+)\]'
        self.source = re.sub(r, lambda m: "array " + m.groups()[0] + " = " + " undef " + m.groups()[1] + "{" + "0, " * (int(m.groups()[2]) - 1) + "0}", self.source)
    
    def expand_strings(self):
        r = r'string\s(\w+)\[(\d)+\]'
        self.source = re.sub(r, lambda m: "string " + m.groups()[0] + " = \"" + ("0") * (int(m.groups()[1]) - 1) + "0\"", self.source)

    # def array_index(self):
    #     r = r'\b(?!int\b|byte\b)(\w+)\[(\w+)\]'
    #     self.source = re.sub(r, lambda m: "*(" + m.groups()[0] + " + " + m.groups()[1] + ")", self.source)

    def hex_repr(self):
        r = r'(0x[\w]+)'
        self.source = re.sub(r, lambda m: str(int(m.groups()[0], 0)), self.source)

    def to_sin_ip(self, addr):
        value = []
        for octect in addr.split("."):
            value.append(format(int(octect), "02x"))
        value.reverse()
        return "0x" + "".join(value)

    def resolve_ip(self):
        r = r'IP\(([\d|.]+)\)'
        self.source = re.sub(r, lambda m: str(int(self.to_sin_ip(m.groups()[0]), 16)), self.source)

    def preprocess(self):
        for rule in self.rules:
            rule()
        return self.source