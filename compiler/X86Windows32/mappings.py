from parser.nodes import *
from llvmlite import ir

test_to_jmp_instruction = {
    "EqualityStatementNode": "jne",
    "InequalityStatementNode": "je",
    "GreaterStatementNode": "jle",
    "GreaterEqualStatementNode": "jl",
    "LowerStatementNode": "jge",
    "LowerEqualStatementNode": "jg"
}

type_mappings = {
    "int8": ir.IntType(8),
    "int16": ir.IntType(16),
    "int32": ir.IntType(32),
    "int64": ir.IntType(64),
}

size_mappings = {
    "i8": 1,
    "i16": 2,
    "i32": 3,
    "i64": 4,
}
