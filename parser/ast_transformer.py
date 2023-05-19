from typing import Any
from lark import Token, Transformer

import parser.nodes as nodes

class AstTransformer(Transformer):

    def LITERAL(self, item):
        return nodes.LiteralExprNode(item.value)
    
    def IDENTIFIER(self, item):
        return nodes.IdentifierExprNode(item.value)
    
    def array(self, items):
        new_items = []
        defined = True
        cnt = 0
        if items[0] == "undef":
            defined = False
        arr_type = items[1]
        cnt += 1
        for item in items[2:]:
            if isinstance(item, str):
                if item not in "\{\},":
                    new_items.append(item)
            else:
                new_items.append(item)
        return nodes.ArrayNode(arr_type, new_items, defined)

    def indexing_stmt(self, items):
        identifier = items[0]
        index = items[2]
        return nodes.IndexingStatementNode(identifier, index)

    def expr(self, items):
        if isinstance(items[0], nodes.ExprNode):
            return items[0]
        else:
            for item in items:
                if isinstance(item, nodes.StatementNode):
                    return item

    def declaration_stmt(self, items):
        type = items[0]
        identifier = items[1]
        expr = None
        if len(items) > 3:
            expr = items[3]
        return nodes.DeclarationStatementNode(type, identifier, expr)

    def assign_stmt(self, items):
        identifier = items[0]
        expr = items[2]
        return nodes.AssignmentStatementNode(identifier, expr)

    def addition_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.AdditionStatementNode(right_hand, left_hand)
    
    def subtraction_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.SubtractionStatementNode(right_hand, left_hand)

    def multiplication_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.MultiplicationStatementNode(right_hand, left_hand)
    
    def division_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.DivisionStatementNode(right_hand, left_hand)
    
    def bitwiseand_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.BitwiseXorStatementNode(right_hand, left_hand)
    
    def bitwiseor_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.BitwiseOrStatementNode(right_hand, left_hand)

    def bitwisexor_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.BitwiseXorStatementNode(right_hand, left_hand)

    def equality_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.EqualityStatementNode(right_hand, left_hand)

    def inequality_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.InequalityStatementNode(right_hand, left_hand)

    def greater_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.GreaterStatementNode(right_hand, left_hand)

    def greatereq_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.GreaterEqualStatementNode(right_hand, left_hand)

    def lower_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.LowerStatementNode(right_hand, left_hand)

    def lowereq_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.LowerEqualStatementNode(right_hand, left_hand)

    def rol_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.RolStatementNode(right_hand, left_hand)

    def rol16_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.Rol16StatementNode(right_hand, left_hand)

    def ror_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.RorStatementNode(right_hand, left_hand)

    def ror16_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.Ror16StatementNode(right_hand, left_hand)

    def shl_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.ShlStatementNode(right_hand, left_hand)

    def shr_stmt(self, items):
        right_hand = items[0]
        left_hand = items[2]
        return nodes.ShrStatementNode(right_hand, left_hand)

    def dereference_stmt(self, items):
        operand = items[1]
        return nodes.DereferenceStatementNode(operand)

    def addressof_stmt(self, items):
        operand = items[1]
        return nodes.AddressOfStatement(operand)

    def negate_stmt(self, items):
        operand = items[1]
        return nodes.NegateStatementNode(operand)

    def comment(self, items):
        text = items[1]
        text = text.value.replace("\n", "")
        return nodes.CommentStatementNode(text)

    def casting_stmt(self, items):
        identifier = items[0]
        new_type = items[2]
        return nodes.CastingStatementNode(identifier, new_type)

    def asm_stmt(self, items):
        inputs = items[1].replace(" ", "").replace("\"", "")
        assembly = items[3]
        outputs = items[5].replace(" ", "").replace("\"", "")
        if inputs != "no_in":
            inputs = {nodes.IdentifierExprNode(k): v for k, v in [x.split(":") for x in inputs.split(",")]}
        if outputs != "no_out":
            outputs = {k: nodes.IdentifierExprNode(v) for k, v in [x.split(":") for x in outputs.split(",")]}
        return nodes.AsmStatementNode(inputs, assembly, outputs)

    def if_stmt(self, items):
        test = items[2]
        if_body = items[4]
        else_body = items[6]
        return nodes.IfStatementNode(test, if_body, else_body)

    def while_stmt(self, items):
        test = items[2]
        body = items[4]
        return nodes.WhileStatementNode(test, body)

    def functioncall_stmt(self, items):
        target = items[0]
        parameters = []
        idx = 1
        while items[idx] != ")":
            if items[idx] != "," and items[idx] != "(":
                parameters.append(items[idx])
            idx += 1
        return nodes.FunctionCallStatementNode(target, parameters)

    def return_stmt(self, items):
        expr = items[1]
        return nodes.ReturnStatementNode(expr)

    def block(self, items):
            statements = items[1:-1]
            return nodes.BlockNode(statements)

    def func_def(self, items):
        type = items[0].value
        identifier = items[1].value
        parameters = items[2:-1]
        body = items[-1]
        return nodes.FunctionNode(type, identifier, parameters, body)

    def syscall_def(self, items):
        function_name = items[0]
        module_name = items[1]
        return nodes.SyscallNode(function_name, module_name)

    def struct_def(self, items):
        struct_name = items[0]
        elements = []
        types = []
        for x in range(1, len(items), 2):
            elements.append(items[x])
            types.append(items[x+1])
        return nodes.StructNode(struct_name, elements, types)
    
    def program(self, items):
        syscalls = []
        functions = []
        for item in items:
            if isinstance(item, nodes.SyscallNode):
                syscalls.append(item)
            elif isinstance(item, nodes.FunctionNode):
                functions.append(item)
        return nodes.ProgramNode(syscalls, functions)
