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

class BinaryOperationNode(Node):
    def __init__(self, left_hand, right_hand):
        self.left_hand = left_hand
        self.right_hand = right_hand        

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

class AdditionStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class SubtractionStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class MultiplicationStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class DivisionStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class BitwiseAndStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class BitwiseOrStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class EqualityStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class GreaterStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class GreaterEqualStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class LowerStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class LowerEqualStatementNode(StatementNode, BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)

class FunctionCallStatementNode(StatementNode):
    def __init__(self, target, parameters):
        self.target = target
        self.parameters = parameters

class IfStatementNode(StatementNode):
    def __init__(self, test, if_body, else_body=None):
        self.test = test
        self.if_body = if_body
        if else_body:
            self.else_body = else_body

class WhileStatementNode(StatementNode):
    def __init__(self, test, body):
        self.test = test
        self.if_body = body

class ReturnStatementNode(StatementNode):
    def __init__(self, expr):
        self.expr = expr

class BlockNode(Node):
    def __init__(self, statements):
        self.statements = statements

class FunctionNode(Node):
    def __init__(self, type, identifier, parameters, body):
        self.type = type
        self.identifier = identifier
        self.parameters = parameters
        self.body = body

class SyscallNode(Node):
    def __init__(self, function_name, module_name):
        self.function_name = function_name
        self.module_name = module_name

class ProgramNode(Node):
    def __init__(self, syscalls, functions): 
        self.syscalls = syscalls       
        self.func_defs = functions