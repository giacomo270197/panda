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


class BinaryOperationNode(StatementNode):
    def __init__(self, left_hand, right_hand):
        self.left_hand = left_hand
        self.right_hand = right_hand


class ComparisonStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class UnaryOperationNode(StatementNode):
    def __init__(self, operand):
        self.operand = operand


class ArrayNode(StatementNode):
    def __init__(self, arr_type, items, defined):
        self.defined = defined
        self.arr_type = arr_type
        self.items = items


class IndexingStatementNode(StatementNode):
    def __init__(self, operand, index):
        self.operand = operand
        self.index = index


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


class AdditionStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class SubtractionStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class MultiplicationStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class DivisionStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class BitwiseAndStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class BitwiseOrStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class BitwiseXorStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class EqualityStatementNode(ComparisonStatementNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class InequalityStatementNode(ComparisonStatementNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class GreaterStatementNode(ComparisonStatementNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class GreaterEqualStatementNode(ComparisonStatementNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class LowerStatementNode(ComparisonStatementNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class LowerEqualStatementNode(ComparisonStatementNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class RolStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class RorStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class Rol16StatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class Ror16StatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class ShlStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class ShrStatementNode(BinaryOperationNode):
    def __init__(self, left_hand, right_hand):
        super().__init__(left_hand, right_hand)


class AddressOfStatement(UnaryOperationNode):
    def __init__(self, operand):
        super().__init__(operand)


class DereferenceStatementNode(UnaryOperationNode):
    def __init__(self, operand):
        super().__init__(operand)


class NegateStatementNode(UnaryOperationNode):
    def __init__(self, operand):
        super().__init__(operand)


class CastingStatementNode(StatementNode):
    def __init__(self, identifier, new_type):
        self.identifier = identifier
        self.new_type = new_type


class AsmStatementNode(StatementNode):
    def __init__(self, input_mapping, assembly, output_mapping):
        self.input_mapping = input_mapping
        self.assembly = assembly
        self.output_mapping = output_mapping


class FunctionCallStatementNode(StatementNode):
    def __init__(self, target, parameters):
        self.target = target
        self.parameters = parameters


class IfStatementNode(StatementNode):
    def __init__(self, test, if_body, else_body=None):
        self.test = test
        self.if_body = if_body
        self.else_body = else_body


class WhileStatementNode(StatementNode):
    def __init__(self, test, body):
        self.test = test
        self.body = body


class ReturnStatementNode(StatementNode):
    def __init__(self, expr):
        self.expr = expr


class CommentStatementNode(StatementNode):
    def __init__(self, text):
        self.text = text


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
