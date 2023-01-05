from typing import Any
from lark import Token, Transformer

import parser.nodes as nodes

class AstTransformer(Transformer):

    def LITERAL(self, item):
        return nodes.LiteralExprNode(item.value)
    
    def IDENTIFIER(self, item):
        return nodes.IdentifierExprNode(item.value)
    
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

    def return_stmt(self, items):
        expr = items[1]
        return nodes.ReturnStatementNode(expr)

    def block(self, items):
            statements = items[1:-1]
            return nodes.BlockNode(statements)
    
    def func_def(self, items):
        type = items[0].value
        identifier = items[1].value
        body = items[2]
        return nodes.FunctionNode(type, identifier, body)
    
    def program(self, items):
        return nodes.ProgramNode(items)
