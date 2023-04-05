	.text
	.def	 @feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 0
	.intel_syntax noprefix
	.file	"example.ll"
	.def	 compute_module_hash;
	.scl	2;
	.type	32;
	.endef
	.globl	compute_module_hash             # -- Begin function compute_module_hash
	.p2align	4, 0x90
compute_module_hash:                    # @compute_module_hash
.seh_proc compute_module_hash
# %bb.0:                                # %.3
	push	rax
	.seh_stackalloc 8
	.seh_endprologue
	mov	dword ptr [rsp + 4], 0
	mov	byte ptr [rsp + 1], 0
	mov	eax, ecx
	.p2align	4, 0x90
.LBB0_2:                                # %loop_1
                                        # =>This Inner Loop Header: Depth=1
	movzx	eax, word ptr [rax]
	mov	word ptr [rsp + 2], ax
	test	ax, ax
	je	.LBB0_3
# %bb.1:                                # %loop_1
                                        #   in Loop: Header=BB0_2 Depth=1
	mov	eax, dword ptr [rsp + 4]
	mov	rdx, rax
	shr	rdx, 13
	shl	eax, 19
	or	edx, eax
	movzx	eax, word ptr [rsp + 2]
	add	eax, edx
	mov	dword ptr [rsp + 4], eax
	movzx	eax, byte ptr [rsp + 1]
	add	rax, 2
	mov	byte ptr [rsp + 1], al
	movzx	eax, al
	add	eax, ecx
	jmp	.LBB0_2
.LBB0_3:                                # %loop_after_1
	mov	eax, dword ptr [rsp + 4]
	pop	rcx
	ret
	.seh_endproc
                                        # -- End function
	.def	 find_module_base;
	.scl	2;
	.type	32;
	.endef
	.globl	find_module_base                # -- Begin function find_module_base
	.p2align	4, 0x90
find_module_base:                       # @find_module_base
.seh_proc find_module_base
# %bb.0:                                # %.3
	push	rbp
	.seh_pushreg rbp
	push	rsi
	.seh_pushreg rsi
	push	rdi
	.seh_pushreg rdi
	sub	rsp, 32
	.seh_stackalloc 32
	lea	rbp, [rsp + 32]
	.seh_setframe rbp, 32
	.seh_endprologue
	mov	esi, ecx
	mov	qword ptr [rbp - 16], 0
	xor	ecx, ecx
	xor	eax, eax
	#APP
	#NO_APP
	#APP
	mov	rax, qword ptr gs:[0]
	#NO_APP
	#APP
	#NO_APP
	mov	qword ptr [rbp - 16], rax
	mov	rax, qword ptr [rax + 96]
	mov	qword ptr [rbp - 16], rax
	mov	rax, qword ptr [rax + 24]
	mov	qword ptr [rbp - 16], rax
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 16], rax
	mov	rdx, qword ptr [rax + 8]
	mov	qword ptr [rbp - 32], rdx
	mov	eax, dword ptr [rax + 32]
	mov	dword ptr [rbp - 20], eax
	mov	byte ptr [rbp - 1], 0
	test	cl, cl
	je	.LBB1_1
.LBB1_2:                                # %loop_2.if
	xor	eax, eax
.LBB1_3:                                # %loop_2.if
	mov	rsp, rbp
	pop	rdi
	pop	rsi
	pop	rbp
	ret
	.p2align	4, 0x90
.LBB1_4:                                # %loop_2.else
                                        #   in Loop: Header=BB1_1 Depth=1
	mov	eax, 16
	call	__chkstk
	sub	rsp, rax
	mov	rdi, rsp
	mov	ecx, dword ptr [rbp - 20]
	sub	rsp, 32
	call	compute_module_hash
	add	rsp, 32
	mov	dword ptr [rdi], eax
	cmp	eax, esi
	je	.LBB1_5
# %bb.6:                                # %loop_2.endif.else
                                        #   in Loop: Header=BB1_1 Depth=1
	cmp	byte ptr [rbp - 1], 0
	jne	.LBB1_2
.LBB1_1:                                # %loop_2
                                        # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 16]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 16], rax
	mov	rcx, qword ptr [rax + 8]
	mov	qword ptr [rbp - 32], rcx
	mov	eax, dword ptr [rax + 32]
	mov	dword ptr [rbp - 20], eax
	test	eax, eax
	jne	.LBB1_4
	jmp	.LBB1_2
.LBB1_5:                                # %loop_2.endif.if
	mov	rax, qword ptr [rbp - 32]
	jmp	.LBB1_3
	.seh_endproc
                                        # -- End function
	.def	 main;
	.scl	2;
	.type	32;
	.endef
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
main:                                   # @main
.seh_proc main
# %bb.0:                                # %.2
	sub	rsp, 56
	.seh_stackalloc 56
	.seh_endprologue
	mov	dword ptr [rsp + 44], -1880304065
	mov	ecx, -1880304065
	call	find_module_base
	mov	qword ptr [rsp + 48], rax
	xor	eax, eax
	add	rsp, 56
	ret
	.seh_endproc
                                        # -- End function
