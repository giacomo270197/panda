import lark
from llvmlite import ir

from compiler.mappings import type_mappings, size_mappings, test_instructions, register_size_mapping, structs_types
from parser.nodes import *
import config


class Assembler:
    def __init__(self, ast):
        self.ast = ast
        self.module = None
        self.functions = {}
        self.syscalls = {}
        self.structs = {}
        self.loops = 0
        self.ifs = 0

    class Variable:
        def __init__(self, ptr, value, var_type):
            self.ptr = ptr
            self.value = value
            self.type = var_type

    class Variables:
        def __init__(self):
            self.parameters = {}
            self.locals = {}

    def adjust_size(self, a, b, builder, preferred_type=None):
        size1 = size_mappings[str(a.type)]
        size2 = size_mappings[str(b.type)]
        if preferred_type:
            preferred_size = size_mappings[str(preferred_type)]
            if size1 < preferred_size:
                a = builder.zext(a, preferred_type)
            if size1 > preferred_size:
                a = builder.trunc(a, preferred_type)
            if size2 < preferred_size:
                b = builder.zext(b, preferred_type)
            if size2 > preferred_size:
                b = builder.trunc(b, preferred_type)
            return a, b
        else:
            if size1 == size2:
                return a, b
            elif size1 > size2:
                b = builder.zext(b, a.type)
                return a, b
            else:
                a = builder.zext(a, b.type)
                return a, b

    def analyze_expression(self, expr, builder, variables, **kwargs):
        if isinstance(expr, LiteralExprNode) or isinstance(expr, lark.Token):
            if "preferred_type" in kwargs:
                return ir.Constant(kwargs["preferred_type"], expr.value)
            return ir.Constant(ir.IntType(int(config.PLATFORM)), expr.value)
        if isinstance(expr, IdentifierExprNode):
            if expr.value == "NULL":
                if "preferred_type" in kwargs:
                    return kwargs["preferred_type"](None)
                return ir.PointerType(ir.IntType(int(config.PLATFORM)))(None)
            if "as_ptr" in kwargs or isinstance(variables.locals[expr.value].type, ir.IdentifiedStructType):
                return variables.locals[expr.value].ptr
            elif isinstance(variables.locals[expr.value].type, ir.ArrayType):
                return builder.bitcast(variables.locals[expr.value].ptr, ir.PointerType(variables.locals[expr.value].type.element))
            else:
                ret = builder.load(variables.locals[expr.value].ptr)
                return ret
        if isinstance(expr, StatementNode):
            if "preferred_type" in kwargs:
                expr.preferred_type = kwargs["preferred_type"]
            if isinstance(expr, IndexingStatementNode):
                return self.process_indexing_statement(expr, builder, variables, "as_ptr" in kwargs)
            if isinstance(expr, AccessStatementNode):
                return self.process_access_statement(expr, builder, variables, "as_ptr" in kwargs)
            elif isinstance(expr, AddressOfStatement):
                return variables.locals[expr.operand.value].ptr
            elif isinstance(expr, DereferenceStatementNode):
                return self.process_dereference_statement(expr, builder, variables, "assign_target" in kwargs)
            elif isinstance(expr, SoftcastStatementNode):
                return self.process_casting_statement(expr, builder, variables, soft=True)
            else:
                if "preferred_type" in kwargs:
                    return self.process_statement(expr, builder, variables, preferred_type=kwargs["preferred_type"])
                return self.process_statement(expr, builder, variables)

    def process_indexing_statement(self, statement, builder, variables, as_ptr):
        operand = self.analyze_expression(statement.operand, builder, variables)
        idx = self.analyze_expression(statement.index, builder, variables)
        tmp = builder.gep(operand, [idx], inbounds=True)
        if not as_ptr:
            tmp = builder.load(tmp)
        return tmp

    def process_access_statement(self, statement, builder, variables, as_ptr):
        parent = self.analyze_expression(statement.parent, builder, variables, as_ptr=True)
        idx = ir.IntType(32)(self.structs[parent.type.pointee.name].index(statement.child.value))
        tmp = builder.gep(parent, [ir.IntType(32)(0), idx], inbounds=True)
        if not as_ptr:
            tmp = builder.load(tmp)
        return tmp

    def process_return_statement(self, statement, builder, variables):
        builder.ret(self.analyze_expression(statement.expr, builder, variables,preferred_type=builder.function.type.pointee.return_type))

    def process_declaration_statement(self, statement, builder, variables):
        if statement.type == "array" or statement.type == "struct":
            value = self.analyze_expression(statement.expr, builder, variables)
            variables.locals[statement.identifier.value] = value
        else:
            actual_type = type_mappings[statement.type]
            ptr = builder.alloca(actual_type, name=statement.identifier.value)
            variables.locals[statement.identifier.value] = self.Variable(ptr, None, actual_type)
            if statement.expr:
                new_statement = AssignmentStatementNode(statement.identifier, statement.expr)
                self.process_statement(new_statement, builder, variables)
            else:
                variables.locals[statement.identifier.value].value = actual_type(0)

    def process_assignment_statement(self, statement, builder, variables):
        identifier = self.analyze_expression(statement.identifier, builder, variables, as_ptr=True, assign_target=True)
        if isinstance(identifier.type, ir.PointerType):
            actual_type = identifier.type.pointee
        else:
            actual_type = identifier.type
        value = self.analyze_expression(statement.expr, builder, variables, preferred_type=actual_type)
        if isinstance(value.type, ir.PointerType):
            builder.store(value, identifier)
        else:
            if size_mappings[str(value.type)] > size_mappings[str(actual_type)]:
                value = builder.trunc(value, actual_type)
            elif size_mappings[str(value.type)] < size_mappings[str(actual_type)]:
                value = builder.zext(value, actual_type)
        builder.store(value, identifier)

    def process_comparison_statement(self, statement, builder, variables):
        sign = test_instructions[statement.__class__.__name__]
        lhs = self.analyze_expression(statement.left_hand, builder, variables)
        rhs = self.analyze_expression(statement.right_hand, builder, variables)
        return builder.icmp_unsigned(sign, lhs, rhs)

    def process_binary_operation_statement(self, statement, builder, variables, **kwargs):
        lhs = self.analyze_expression(statement.left_hand, builder, variables)
        rhs = self.analyze_expression(statement.right_hand, builder, variables)
        if isinstance(lhs.type, ir.PointerType):
            lhs = builder.ptrtoint(lhs, lhs.type.pointee)
        if isinstance(rhs.type, ir.PointerType):
            rhs = builder.ptrtoint(rhs, rhs.type.pointee)
        preferred_type = None
        if "preferred_type" in kwargs:
            preferred_type = kwargs["preferred_type"]
        lhs, rhs = self.adjust_size(lhs, rhs, builder, preferred_type=preferred_type)
        tmp = None
        if isinstance(statement, AdditionStatementNode):
            tmp = builder.add(lhs, rhs)
        elif isinstance(statement, SubtractionStatementNode):
            tmp = builder.sub(lhs, rhs)
        elif isinstance(statement, MultiplicationStatementNode):
            tmp = builder.mul(lhs, rhs)
        elif isinstance(statement, DivisionStatementNode):
            tmp = builder.udiv(lhs, rhs)
        elif isinstance(statement, BitwiseAndStatementNode):
            tmp = builder.and_(lhs, rhs)
        elif isinstance(statement, BitwiseOrStatementNode):
            tmp = builder.or_(lhs, rhs)
        elif isinstance(statement, BitwiseXorStatementNode):
            tmp = builder.xor(lhs, rhs)
        elif isinstance(statement, ShlStatementNode):
            tmp = builder.shl(lhs, rhs)
        elif isinstance(statement, ShrStatementNode):
            tmp = builder.lshr(lhs, rhs)
        return tmp

    def process_dereference_statement(self, statement, builder, variables, assign_target):
        operand = self.analyze_expression(statement.operand, builder, variables)
        if not isinstance(operand.type, ir.PointerType):
            try:
                assignment_type = getattr(statement, "preferred_type")
                operand = builder.inttoptr(operand, ir.PointerType(assignment_type))
            except AttributeError:
                operand = builder.inttoptr(operand, ir.PointerType(operand.type))
        if not assign_target:
            operand = builder.load(operand)
        return operand

    def process_unary_operation_statement(self, statement, builder, variables):
        operand = self.analyze_expression(statement.operand, builder, variables)
        tmp = None
        if isinstance(statement, NegateStatementNode):
            tmp = builder.neg(operand)
        return tmp

    def process_aggregate_statement(self, statement, builder, variables):
        agg_type = None
        if isinstance(statement, ArrayNode):
            agg_type = ir.ArrayType(type_mappings[statement.agg_type.value], len(statement.items))
        elif isinstance(statement, StructNode):
            agg_type = self.module.context.get_identified_type(statement.agg_type.value)
        agg = builder.alloca(agg_type)
        new_agg = ir.Constant(agg_type, None)
        builder.store(new_agg, agg)
        if statement.defined:
            for x, y in zip(statement.items, range(len(statement.items))):
                if isinstance(statement, ArrayNode):
                    val = self.analyze_expression(x, builder, variables, preferred_type=type_mappings[statement.agg_type.value])
                else:
                    val = self.analyze_expression(x, builder, variables, preferred_type=structs_types[statement.agg_type.value][y])
                first = ir.Constant(ir.IntType(32), 0)
                idx = ir.Constant(ir.IntType(32), y)
                elem_ptr = builder.gep(agg, [first, idx], inbounds=True)
                builder.store(val, elem_ptr)
        return self.Variable(agg, new_agg, agg_type)

    def process_function_call_statement(self, statement, builder, variables):
        address = None
        idx = ir.Constant(ir.IntType(8), 0)
        if statement.target.value in self.syscalls:
            find_func = self.functions["_find_function"]
            syscall = self.syscalls[statement.target.value]
            arr_type = ir.ArrayType(ir.IntType(8), len(syscall["module_name"]) + 1)
            arr = builder.alloca(arr_type)
            new_arr = ir.Constant(arr_type, bytearray(syscall["module_name"], "ascii") + b"\x00")
            builder.store(new_arr, arr)
            find_params = [
                ir.Constant(ir.IntType(32), syscall["function_hash"]),
                ir.Constant(ir.IntType(32), syscall["module_hash"]),
                builder.bitcast(arr, ir.PointerType(ir.IntType(8))),
            ]
            address = builder.call(find_func, find_params, cconv="ccc")
            statement.target.value = "_call_{}".format(statement.target.value)
        func = self.functions[statement.target.value]
        params = []
        for x, y in zip(statement.parameters, func.args):
            if isinstance(x, StatementNode):
                value = self.analyze_expression(x, builder, variables, preferred_type=y.type)
            elif x.value in variables.locals and isinstance(variables.locals[x.value].type, ir.ArrayType):
                value = self.analyze_expression(x, builder, variables, as_ptr=True)
                value = builder.gep(value, [idx, idx])
            elif x.value in variables.locals and isinstance(variables.locals[x.value].type, ir.IdentifiedStructType):
                value = self.analyze_expression(x, builder, variables, as_ptr=True)
            else:
                value = self.analyze_expression(x, builder, variables, preferred_type=y.type)
                if isinstance(value.type, ir.PointerType) and value.type.pointee.intrinsic_name in self.structs.keys():
                    value = builder.ptrtoint(value, ir.IntType(int(config.PLATFORM)))
            params.append(value)
        if address:
            params.append(address)
        ret = builder.call(func, params)
        return ret

    def process_if_statement(self, statement, builder, variables):
        test = self.analyze_expression(statement.test, builder, variables)
        with builder.if_else(test) as (then, otherwise):
            with then:
                self.process_branch_block(statement.if_body, builder, variables)
            with otherwise:
                if statement.else_body:
                    self.process_branch_block(statement.else_body, builder, variables)

    def process_while_statement(self, statement, builder, variables):
        self.loops += 1
        loop = builder.append_basic_block("loop_{}".format(str(self.loops)))
        after = builder.append_basic_block("loop_after_{}".format(str(self.loops)))
        builder.cbranch(self.analyze_expression(statement.test, builder, variables), loop, after)
        builder.position_at_start(loop)
        self.process_branch_block(statement.body, builder, variables)
        builder.cbranch(self.analyze_expression(statement.test, builder, variables), loop, after)
        builder.position_at_start(after)

    def process_asm_statement(self, statement, builder, variables):
        for var, reg in statement.input_mapping.items():
            val = self.analyze_expression(var, builder, variables)
            if isinstance(val.type, ir.PointerType):
                size = register_size_mapping[reg]
                val = builder.ptrtoint(val, ir.IntType(size))
            builder.store_reg(val, ir.IntType(register_size_mapping[reg]), reg)
        fty = ir.FunctionType(ir.VoidType(), [])
        statement.assembly = statement.assembly.replace("\"", "").replace("\\n", "\n")
        builder.asm(fty, statement.assembly.replace("\"", ""), "", [], False)
        for reg, val in statement.output_mapping.items():
            tmp = builder.load_reg(ir.IntType(register_size_mapping[reg]), reg)
            ptr = self.analyze_expression(val, builder, variables, as_ptr=True)
            builder.store(tmp, ptr)

    def process_casting_statement(self, statement, builder, variables, soft=False):
        val = self.analyze_expression(statement.identifier, builder, variables)
        new_type = type_mappings[statement.new_type.value.replace("\"", "")]
        old_type = val.type
        value = None
        if old_type == new_type:
            return val
        if isinstance(old_type, ir.PointerType):
            if isinstance(new_type, ir.PointerType):
                value = builder.bitcast(val, new_type)
            else:
                value = builder.ptrtoint(val, variables.locals[statement.identifier.value].type)
        else:
            if isinstance(new_type, ir.PointerType):
                value = builder.inttoptr(val, new_type)
            else:
                if size_mappings[str(old_type)] > size_mappings[str(new_type)]:
                    value = builder.trunc(val, new_type)
                elif size_mappings[str(old_type)] < size_mappings[str(new_type)]:
                    value = builder.zext(val, new_type)
        if not soft:
            new_ptr = builder.alloca(new_type)
            builder.store(value, new_ptr)
            variables.locals[statement.identifier.value].type = new_type
            variables.locals[statement.identifier.value].ptr = new_ptr
        else:
            return value

    def process_statement(self, statement, builder, variables, **kwargs):
        if isinstance(statement, ReturnStatementNode):
            self.process_return_statement(statement, builder, variables)
        elif isinstance(statement, DeclarationStatementNode):
            self.process_declaration_statement(statement, builder, variables)
        elif isinstance(statement, AssignmentStatementNode):
            self.process_assignment_statement(statement, builder, variables)
        elif isinstance(statement, ComparisonStatementNode):
            return self.process_comparison_statement(statement, builder, variables)
        elif isinstance(statement, BinaryOperationNode):
            if "preferred_type" in kwargs:
                return self.process_binary_operation_statement(statement, builder, variables, preferred_type=kwargs["preferred_type"])
            else:
                return self.process_binary_operation_statement(statement, builder, variables)
        elif isinstance(statement, UnaryOperationNode):
            return self.process_unary_operation_statement(statement, builder, variables)
        elif isinstance(statement, AggregateNode):
            return self.process_aggregate_statement(statement, builder, variables)
        elif isinstance(statement, FunctionCallStatementNode):
            return self.process_function_call_statement(statement, builder, variables)
        elif isinstance(statement, IfStatementNode):
            self.process_if_statement(statement, builder, variables)
        elif isinstance(statement, WhileStatementNode):
            self.process_while_statement(statement, builder, variables)
        elif isinstance(statement, AsmStatementNode):
            self.process_asm_statement(statement, builder, variables)
        elif isinstance(statement, CastingStatementNode):
            self.process_casting_statement(statement, builder, variables)
        elif isinstance(statement, CommentStatementNode):
            pass
        else:
            exit("Node handling not implemented for {}".format(statement.__class__.__name__))

    def process_branch_block(self, block, builder, variables):
        for statement in block.statements:
            self.process_statement(statement, builder, variables)

    def process_block(self, block, function, variables):
        ir_block = function.append_basic_block()
        builder = ir.IRBuilder(ir_block)
        for param, value in variables.parameters.items():
            ptr = builder.alloca(value.type)
            builder.store(value, ptr)
            variables.locals[param] = self.Variable(ptr, value, value.type)
        for statement in block.statements:
            self.process_statement(statement, builder, variables)

    def process_function(self, function):
        func_body = function.body
        func_identifier = function.identifier
        variables = self.Variables()
        param_names = [function.parameters[x].value for x in range(len(function.parameters)) if x % 2 != 0]
        func = self.functions[func_identifier]
        for param, name in zip(func.args, param_names):
            variables.parameters[name] = param
        self.process_block(func_body, func, variables)

    def define_funcs(self, function):
        func_type = function.type
        func_identifier = function.identifier
        func_parameters = function.parameters
        new_func_type = ir.FunctionType(type_mappings[func_type],
                                        [type_mappings[func_parameters[x].value] for x in range(len(func_parameters)) if
                                         x % 2 == 0])
        func = ir.Function(self.module, new_func_type, name=func_identifier)
        self.functions[func_identifier] = func

    def ror_str(self, b, count):
        b = "{0:b}".format(b)
        binb = (32 - len(b)) * '0' + b
        while count > 0:
            binb = binb[-1] + binb[0:-1]
            count -= 1
        return int(binb, 2)

    def compute_hash(self, name, is_dll=False):
        edx = 0x00
        ror_count = 0
        if is_dll:
            name = name.upper()
        for eax in name:
            edx = edx + ord(eax)
            if ror_count < len(name) - 1:
                edx = self.ror_str(edx, 0xd)
            ror_count += 1
        return edx

    def define_structs(self, struct_def):
        types = [type_mappings[x] for x in struct_def.types]
        struct_type = self.module.context.get_identified_type(struct_def.struct_name.value)
        struct_type.set_body(*types)
        type_mappings[struct_def.struct_name.value] = ir.PointerType(struct_type)
        structs_types[struct_def.struct_name.value] = types
        self.structs[struct_def.struct_name.value] = [x.value for x in struct_def.elements]

    def create_assembly(self):
        self.module = ir.Module(name="Shellcode")
        for declare in self.ast.syscalls:
            self.syscalls[declare.function_name.value.replace("\"", "")] = {
                "function_hash": self.compute_hash(declare.function_name.value.replace("\"", "")),
                "module_hash": self.compute_hash(declare.module_name.value.replace("\"", ""), True),
                "module_name": declare.module_name.value.replace("\"", "")
            }
        for struct_def in self.ast.structs:
            self.define_structs(struct_def)
        for function in self.ast.func_defs:
            self.define_funcs(function)
        for function in self.ast.func_defs:
            self.process_function(function)
        with open("example.ll", "w") as f:
            f.write(str(self.module))
