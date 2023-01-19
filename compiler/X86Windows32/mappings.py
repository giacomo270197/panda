from parser.nodes import *
from compiler.X86Windows32.X86Windows32 import *

node_to_builder_map = {
    "FunctionNode":                 FunctionAssemblyBuilder,
    "ArrayNode":                    ArrayNodeAssemblyBuilder,
    "DeclarationStatementNode":     DeclarationStatementAssemblyBuilder,
    "AdditionStatementNode":        AdditionStatementAssemblyBuilder,
    "ReturnStatementNode":          ReturnStatementAssemblyBuilder,
    "AssignmentStatementNode":      AssignmentStatementAssemblyBuilder,
    "SubtractionStatementNode":     SubtractionStatementAssemblyBuilder,
    "MultiplicationStatementNode" : MultiplicationStatementAssemblyBuilder,
    "DivisionStatementNode":        DivisionStatementAssemblyBuilder,
    "BitwiseAndStatementNode":      BitwiseAndStatementAssemblyBuilder,
    "BitwiseOrStatementNode":       BitwiseOrStatementAssemblyBuilder,
    "FunctionCallStatementNode":    FunctionCallStatementAssemblyBuilder,
    "EqualityStatementNode":        EqualityStatementAssemblyBuilder,
    "InequalityStatementNode":      InequalityStatementAssemblyBuilder,
    "GreaterStatementNode":         GreaterStatementAssemblyBuilder,
    "GreaterEqualStatementNode":    GreaterEqualStatementAssemblyBuilder,
    "LowerStatementNode":           LowerStatementAssemblyBuilder,
    "LowerEqualStatementNode":      LowerEqualStatementAssemblyBuilder,
    "AddressOfStatement":           AddressOfStatementAssemblyBuilder,
    "DereferenceStatementNode":     DereferenceStatementAssemblyBuilder,
    "IfStatementNode":              IfStatementAssemblyBuilder,
    "WhileStatementNode":           WhileStatementAssemblyBuilder
}

test_to_jmp_instruction = {
    "EqualityStatementNode":        "jne",
    "InequalityStatementNode":      "je",
    "GreaterStatementNode":         "jle",
    "GreaterEqualStatementNode":    "jl",
    "LowerStatementNode":           "jge",
    "LowerEqualStatementNode":      "jg"   
}