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
    "MultiplicationStatementNode":  MultiplicationStatementAssemblyBuilder,
    "DivisionStatementNode":        DivisionStatementAssemblyBuilder,
    "BitwiseAndStatementNode":      BitwiseAndStatementAssemblyBuilder,
    "BitwiseOrStatementNode":       BitwiseOrStatementAssemblyBuilder,
    "BitwiseXorStatementNode":      BitwiseXorStatementAssemblyBuilder,
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
    "WhileStatementNode":           WhileStatementAssemblyBuilder,
    "CastingStatementNode":         CastingStatementAssemblyBuilder,
    "RorStatementNode":             RorStatementAssemblyBuilder,
    "RolStatementNode":             RolStatementAssemblyBuilder,
    "Rol16StatementNode":           Rol16StatementAssemblyBuilder,
    "Ror16StatementNode":           Ror16StatementAssemblyBuilder,
    "ShlStatementNode":             ShlStatementAssemblyBuilder,
    "ShrStatementNode":             ShlStatementAssemblyBuilder,
    "NegateStatementNode":          NegateStatementAssemblyBuilder,
    "CommentStatementNode":         CommentStatementAssemblyBuilder
}

test_to_jmp_instruction = {
    "EqualityStatementNode":        "jne",
    "InequalityStatementNode":      "je",
    "GreaterStatementNode":         "jle",
    "GreaterEqualStatementNode":    "jl",
    "LowerStatementNode":           "jge",
    "LowerEqualStatementNode":      "jg"   
}