from llvmlite import ir

test_instructions = {
    "EqualityStatementNode": "==",
    "InequalityStatementNode": "!=",
    "GreaterStatementNode": ">",
    "GreaterEqualStatementNode": ">=",
    "LowerStatementNode": "<",
    "LowerEqualStatementNode": "<="
}

type_mappings = {
    "int8": ir.IntType(8),
    "int16": ir.IntType(16),
    "int32": ir.IntType(32),
    "int64": ir.IntType(64),
    "ptr int8": ir.PointerType(ir.IntType(8)),
    "ptr int16": ir.PointerType(ir.IntType(16)),
    "ptr int32": ir.PointerType(ir.IntType(32)),
    "ptr int64": ir.PointerType(ir.IntType(64))
}

size_mappings = {
    "i8": 1,
    "i16": 2,
    "i32": 3,
    "i64": 4,
}
