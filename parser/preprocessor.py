import re


def string_to_arr(string):
    val = []
    for x in string:
        val.append(hex(ord(x)))
    val.append("0x0")
    return ", ".join(val)


class Preprocessor:
    source = None
    heuristics = []

    def __init__(self, source):
        self.source = source
        self.rules = [self.increment_shorthand, self.decrement_shorthand, self.multiplication_shorthand,
                      self.division_shorthand, self.expand_arrays, self.expand_strings, self.hex_repr, self.resolve_ip,
                      self.create_syscalls]

    def increment_shorthand(self):
        r = r'((.)*?)\+=(.*?);'
        self.source = re.sub(r, lambda m: m.groups()[0] + "=" + m.groups()[0] + "+" + m.groups()[2] + ";", self.source)

    def decrement_shorthand(self):
        r = r'((.)*?)-=(.*?);'
        self.source = re.sub(r, lambda m: m.groups()[0] + "=" + m.groups()[0] + "-" + m.groups()[2] + ";", self.source)

    def multiplication_shorthand(self):
        r = r'((.)*?)\*=(.*?);'
        self.source = re.sub(r, lambda m: m.groups()[0] + "=" + m.groups()[0] + "*" + m.groups()[2] + ";", self.source)

    def division_shorthand(self):
        r = r'((.)*?)\/=(.*?);'
        self.source = re.sub(r, lambda m: m.groups()[0] + "=" + m.groups()[0] + "/" + m.groups()[2] + ";", self.source)

    def expand_arrays(self):
        r = r'array\s(\w+)+?\s(int8|int16|int32|int64|ptr int8|ptr int16|ptr int32|ptr int64)\[(\d+)\]'
        self.source = re.sub(r, lambda m: "array " + m.groups()[0] + " = " + m.groups()[1] + "{" + "0, " * (
                    int(m.groups()[2]) - 1) + "0}", self.source)

    def expand_strings(self):
        r = r'string\s+?(\w+?)\s=\s+?"(.*?)"\s*?;'
        self.source = re.sub(r, lambda m: "array " + m.groups()[0] + " =  int8{" + string_to_arr(m.groups()[1]) + "};",
                             self.source)

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

    def create_syscalls(self):
        r = r'declare\("(\w+)"\s*,\s*"([\w.]+)"\s*\)\s*\(([\w\s,]+)\)\s*;'
        for line in self.source.split("\n"):
            if line[:7] == 'declare':
                g = re.search(r, line)
                params = g.groups()[2].split(",")
                params = [x + " " + chr(65 + y) + "," for x, y in zip(params, range(len(params)))]
                param_len = len(params)
                params.append("int32 address")
                params = "".join(params)
                push_str = "mov %esp,%esi\\n"
                for x in range(param_len, 0, -1):
                    push_str += "push {}(%esi)\\n".format(str(4 + 4 * (x+1)))
                self.source += """
                
int32 fn call_{}({}) {{
    int32 out = 0;
    _asm("address:eax", "{}call eax", "eax:out");
    return address;
}}

                """.format(g.groups()[0], params, push_str)
            else:
                break

    def preprocess(self):
        for rule in self.rules:
            rule()
        return self.source
