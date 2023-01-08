import abc

class Node(abc.ABC):
    pass

class ExprNode(Node):
    pass        

class LiteralExprNode(ExprNode):
    def __init__(self, value):
        self.value = value

class IdentifierExprNode(ExprNode):
    def __init__(self, value):
        self.value = value

class StatementNode(Node):
    pass

class DeclarationStatementNode(StatementNode):
    def __init__(self, type, identifier, expr=None):
        self.type = type
        self.identifier = identifier
        if expr:
            self.expr = expr

class AssignmentStatementNode(StatementNode):
    def __init__(self, identifier, expr):
        self.identifier = identifier
        self.expr = expr

class AdditionStatementNode(StatementNode):
    def __init__(self, left_hand, right_hand):
        self.left_hand = left_hand
        self.right_hand = right_hand

class SubtractionStatementNode(StatementNode):
    def __init__(self, left_hand, right_hand):
        self.left_hand = left_hand
        self.right_hand = right_hand

class MultiplicationStatementNode(StatementNode):
    def __init__(self, left_hand, right_hand):
        self.left_hand = left_hand
        self.right_hand = right_hand

class DivisionStatementNode(StatementNode):
    def __init__(self, left_hand, right_hand):
        self.left_hand = left_hand
        self.right_hand = right_hand

class BitwiseAndStatementNode(StatementNode):
    def __init__(self, left_hand, right_hand):
        self.left_hand = left_hand
        self.right_hand = right_hand

class BitwiseOrStatementNode(StatementNode):
    def __init__(self, left_hand, right_hand):
        self.left_hand = left_hand
        self.right_hand = right_hand

class FunctionCallStatementNode(StatementNode):
    def __init__(self, target, parameters):
        self.target = target
        self.parameters = parameters

class ReturnStatementNode(StatementNode):
    def __init__(self, expr):
        self.expr = expr

# Block node, one or more per function
class BlockNode(Node):
    def __init__(self, statements):
        self.statements = statements

# Function node, one per function in the program
class FunctionNode(Node):
    def __init__(self, type, identifier, parameters, body):
        self.type = type
        self.identifier = identifier
        self.parameters = parameters
        self.body = body

# Top level program node, one per program
class ProgramNode(Node):
    def __init__(self, functions):        
        self.func_defs = functions