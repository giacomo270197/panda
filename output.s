	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 0
	.intel_syntax noprefix
	.file	"example.ll"
	.def	to_lowercase;
	.scl	2;
	.type	32;
	.endef
	.globl	to_lowercase                    # -- Begin function to_lowercase
	.p2align	4, 0x90
to_lowercase:                           # @to_lowercase
.seh_proc to_lowercase
# %bb.0:                                # %.3
	sub	rsp, 16
	.seh_stackalloc 16
	.seh_endprologue
	mov	word ptr [rsp + 6], cx          # 2-byte Spill
	movzx	eax, cx
                                        # kill: def $rax killed $eax
	mov	qword ptr [rsp + 8], rax
	cmp	qword ptr [rsp + 8], 97
	jb	.LBB0_2
# %bb.1:                                # %.3.if
	cmp	qword ptr [rsp + 8], 122
	jbe	.LBB0_4
	jmp	.LBB0_5
.LBB0_2:                                # %.3.else
	jmp	.LBB0_3
.LBB0_3:                                # %.3.endif
	mov	ax, word ptr [rsp + 6]          # 2-byte Reload
	add	rsp, 16
	ret
.LBB0_4:                                # %.3.if.if
	mov	rax, qword ptr [rsp + 8]
	sub	rax, 32
	mov	qword ptr [rsp + 8], rax
	jmp	.LBB0_6
.LBB0_5:                                # %.3.if.else
	jmp	.LBB0_6
.LBB0_6:                                # %.3.if.endif
	jmp	.LBB0_3
	.seh_endproc
                                        # -- End function
	.def	compute_function_hash;
	.scl	2;
	.type	32;
	.endef
	.globl	compute_function_hash           # -- Begin function compute_function_hash
	.p2align	4, 0x90
compute_function_hash:                  # @compute_function_hash
.seh_proc compute_function_hash
# %bb.0:                                # %.3
	sub	rsp, 16
	.seh_stackalloc 16
	.seh_endprologue
	mov	qword ptr [rsp], rcx            # 8-byte Spill
	mov	dword ptr [rsp + 12], 0
	mov	byte ptr [rsp + 11], 0
	movzx	eax, byte ptr [rsp + 11]
                                        # kill: def $rax killed $eax
	add	rcx, rax
	mov	al, byte ptr [rcx]
	mov	byte ptr [rsp + 10], al
	cmp	byte ptr [rsp + 10], 0
	je	.LBB1_2
.LBB1_1:                                # %loop_1
                                        # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	mov	ecx, dword ptr [rsp + 12]
                                        # kill: def $rcx killed $ecx
	sar	rcx, 13
	mov	edx, dword ptr [rsp + 12]
                                        # kill: def $rdx killed $edx
	shl	rdx, 19
	or	rcx, rdx
                                        # kill: def $ecx killed $ecx killed $rcx
	mov	dword ptr [rsp + 12], ecx
	mov	ecx, dword ptr [rsp + 12]
	movzx	edx, byte ptr [rsp + 10]
	add	ecx, edx
	mov	dword ptr [rsp + 12], ecx
	movzx	ecx, byte ptr [rsp + 11]
                                        # kill: def $rcx killed $ecx
	add	rcx, 1
                                        # kill: def $cl killed $cl killed $rcx
	mov	byte ptr [rsp + 11], cl
	movzx	ecx, byte ptr [rsp + 11]
                                        # kill: def $rcx killed $ecx
	add	rax, rcx
	mov	al, byte ptr [rax]
	mov	byte ptr [rsp + 10], al
	cmp	byte ptr [rsp + 10], 0
	jne	.LBB1_1
.LBB1_2:                                # %loop_after_1
	mov	eax, dword ptr [rsp + 12]
	add	rsp, 16
	ret
	.seh_endproc
                                        # -- End function
	.def	find_actual_dll_name;
	.scl	2;
	.type	32;
	.endef
	.globl	find_actual_dll_name            # -- Begin function find_actual_dll_name
	.p2align	4, 0x90
find_actual_dll_name:                   # @find_actual_dll_name
.seh_proc find_actual_dll_name
# %bb.0:                                # %.3
	sub	rsp, 32
	.seh_stackalloc 32
	.seh_endprologue
	mov	qword ptr [rsp], rcx            # 8-byte Spill
	mov	qword ptr [rsp + 24], 0
	mov	qword ptr [rsp + 16], 0
	add	rcx, qword ptr [rsp + 24]
	mov	al, byte ptr [rcx]
	mov	byte ptr [rsp + 15], al
	cmp	byte ptr [rsp + 15], 0
	je	.LBB2_2
.LBB2_1:                                # %loop_2
                                        # =>This Inner Loop Header: Depth=1
	cmp	byte ptr [rsp + 15], 92
	je	.LBB2_3
	jmp	.LBB2_4
.LBB2_2:                                # %loop_after_2
	mov	rax, qword ptr [rsp + 16]
	add	rax, 2
	add	rsp, 32
	ret
.LBB2_3:                                # %loop_2.if
                                        #   in Loop: Header=BB2_1 Depth=1
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	add	rax, qword ptr [rsp + 24]
	mov	qword ptr [rsp + 16], rax
	jmp	.LBB2_5
.LBB2_4:                                # %loop_2.else
                                        #   in Loop: Header=BB2_1 Depth=1
	jmp	.LBB2_5
.LBB2_5:                                # %loop_2.endif
                                        #   in Loop: Header=BB2_1 Depth=1
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	mov	rcx, qword ptr [rsp + 24]
	add	rcx, 2
	mov	qword ptr [rsp + 24], rcx
	add	rax, qword ptr [rsp + 24]
	mov	al, byte ptr [rax]
	mov	byte ptr [rsp + 15], al
	cmp	byte ptr [rsp + 15], 0
	jne	.LBB2_1
	jmp	.LBB2_2
	.seh_endproc
                                        # -- End function
	.def	compute_module_hash;
	.scl	2;
	.type	32;
	.endef
	.globl	compute_module_hash             # -- Begin function compute_module_hash
	.p2align	4, 0x90
compute_module_hash:                    # @compute_module_hash
.seh_proc compute_module_hash
# %bb.0:                                # %.3
	sub	rsp, 56
	.seh_stackalloc 56
	.seh_endprologue
	call	find_actual_dll_name
	mov	qword ptr [rsp + 48], rax
	mov	dword ptr [rsp + 44], 0
	mov	byte ptr [rsp + 43], 0
	mov	rax, qword ptr [rsp + 48]
	movzx	ecx, byte ptr [rsp + 43]
                                        # kill: def $rcx killed $ecx
	add	rax, rcx
	mov	ax, word ptr [rax]
	mov	word ptr [rsp + 40], ax
	mov	cx, word ptr [rsp + 40]
	call	to_lowercase
	mov	word ptr [rsp + 40], ax
	cmp	word ptr [rsp + 40], 0
	je	.LBB3_2
.LBB3_1:                                # %loop_3
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rsp + 44]
                                        # kill: def $rax killed $eax
	sar	rax, 13
	mov	ecx, dword ptr [rsp + 44]
                                        # kill: def $rcx killed $ecx
	shl	rcx, 19
	or	rax, rcx
                                        # kill: def $eax killed $eax killed $rax
	mov	dword ptr [rsp + 44], eax
	mov	eax, dword ptr [rsp + 44]
	movzx	ecx, word ptr [rsp + 40]
	add	eax, ecx
	mov	dword ptr [rsp + 44], eax
	movzx	eax, byte ptr [rsp + 43]
                                        # kill: def $rax killed $eax
	add	rax, 2
                                        # kill: def $al killed $al killed $rax
	mov	byte ptr [rsp + 43], al
	mov	rax, qword ptr [rsp + 48]
	movzx	ecx, byte ptr [rsp + 43]
                                        # kill: def $rcx killed $ecx
	add	rax, rcx
	mov	ax, word ptr [rax]
	mov	word ptr [rsp + 40], ax
	cmp	word ptr [rsp + 40], 0
	jne	.LBB3_1
.LBB3_2:                                # %loop_after_3
	mov	eax, dword ptr [rsp + 44]
	add	rsp, 56
	ret
	.seh_endproc
                                        # -- End function
	.def	find_module_base;
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
	sub	rsp, 48
	.seh_stackalloc 48
	lea	rbp, [rsp + 48]
	.seh_setframe rbp, 48
	.seh_endprologue
	mov	dword ptr [rbp - 16], ecx       # 4-byte Spill
	mov	qword ptr [rbp - 8], 0
	mov	rax, qword ptr [rbp - 8]
	#APP
	#NO_APP
	#APP
	mov	rax, qword ptr gs:[48]
	#NO_APP
	#APP
	#NO_APP
	mov	qword ptr [rbp - 8], rax
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax + 96]
	mov	qword ptr [rbp - 8], rax
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax + 24]
	mov	qword ptr [rbp - 8], rax
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 8], rax
	mov	byte ptr [rbp - 9], 0
	cmp	byte ptr [rbp - 9], 0
	jne	.LBB4_2
.LBB4_1:                                # %loop_4
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, 16
	mov	qword ptr [rbp - 32], rax       # 8-byte Spill
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 32]       # 8-byte Reload
	mov	r8, rsp
	mov	rcx, r8
	mov	qword ptr [rbp - 40], rcx       # 8-byte Spill
	mov	rcx, qword ptr [rbp - 8]
	mov	rcx, qword ptr [rcx - 16]
	mov	qword ptr [r8], rcx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 32]       # 8-byte Reload
	mov	rdx, rsp
	mov	rcx, rdx
	mov	qword ptr [rbp - 24], rcx       # 8-byte Spill
	mov	r8, qword ptr [r8]
	mov	r8, qword ptr [r8 + 80]
	mov	qword ptr [rdx], r8
	call	__chkstk
	sub	rsp, rax
	mov	rax, rsp
	mov	rcx, qword ptr [rcx]
	mov	cx, word ptr [rcx]
	mov	word ptr [rax], cx
	cmp	word ptr [rax], 0
	je	.LBB4_3
	jmp	.LBB4_4
.LBB4_2:                                # %loop_after_4
	xor	eax, eax
                                        # kill: def $rax killed $eax
	mov	rsp, rbp
	pop	rbp
	ret
.LBB4_3:                                # %loop_4.if
	xor	eax, eax
                                        # kill: def $rax killed $eax
	mov	rsp, rbp
	pop	rbp
	ret
.LBB4_4:                                # %loop_4.else
                                        #   in Loop: Header=BB4_1 Depth=1
	jmp	.LBB4_5
.LBB4_5:                                # %loop_4.endif
                                        #   in Loop: Header=BB4_1 Depth=1
	mov	eax, 16
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 24]       # 8-byte Reload
	mov	rcx, rsp
	mov	qword ptr [rbp - 48], rcx       # 8-byte Spill
	mov	rcx, qword ptr [rax]
	sub	rsp, 32
	call	compute_module_hash
	mov	ecx, dword ptr [rbp - 16]       # 4-byte Reload
	add	rsp, 32
	mov	edx, eax
	mov	rax, qword ptr [rbp - 48]       # 8-byte Reload
	mov	dword ptr [rax], edx
	cmp	dword ptr [rax], ecx
	jne	.LBB4_7
# %bb.6:                                # %loop_4.endif.if
	mov	rax, qword ptr [rbp - 40]       # 8-byte Reload
	mov	rax, qword ptr [rax]
	mov	rax, qword ptr [rax + 48]
	mov	rsp, rbp
	pop	rbp
	ret
.LBB4_7:                                # %loop_4.endif.else
                                        #   in Loop: Header=BB4_1 Depth=1
	jmp	.LBB4_8
.LBB4_8:                                # %loop_4.endif.endif
                                        #   in Loop: Header=BB4_1 Depth=1
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 8], rax
	cmp	byte ptr [rbp - 9], 0
	je	.LBB4_1
	jmp	.LBB4_2
	.seh_endproc
                                        # -- End function
	.def	find_function;
	.scl	2;
	.type	32;
	.endef
	.globl	find_function                   # -- Begin function find_function
	.p2align	4, 0x90
find_function:                          # @find_function
.seh_proc find_function
# %bb.0:                                # %.5
	push	rbp
	.seh_pushreg rbp
	sub	rsp, 96
	.seh_stackalloc 96
	lea	rbp, [rsp + 96]
	.seh_setframe rbp, 96
	.seh_endprologue
	mov	qword ptr [rbp - 24], r8        # 8-byte Spill
	mov	dword ptr [rbp - 16], edx       # 4-byte Spill
	mov	eax, ecx
	mov	ecx, dword ptr [rbp - 16]       # 4-byte Reload
	mov	dword ptr [rbp - 12], eax       # 4-byte Spill
	sub	rsp, 32
	call	find_module_base
	add	rsp, 32
	mov	qword ptr [rbp - 8], rax
	cmp	qword ptr [rbp - 8], 0
	jne	.LBB5_2
# %bb.1:                                # %.5.if
	mov	r8, qword ptr [rbp - 24]        # 8-byte Reload
	mov	eax, 16
	call	__chkstk
	sub	rsp, rax
	mov	rax, rsp
	mov	qword ptr [rbp - 32], rax       # 8-byte Spill
	mov	ecx, 3960360590
	mov	edx, 1848363543
	sub	rsp, 32
	call	find_function
	mov	rcx, qword ptr [rbp - 24]       # 8-byte Reload
	add	rsp, 32
	mov	rdx, rax
	mov	rax, qword ptr [rbp - 32]       # 8-byte Reload
	mov	qword ptr [rax], rdx
	mov	rax, qword ptr [rax]
	#APP
	#NO_APP
	#APP
	#NO_APP
	#APP
	call	rax
	#NO_APP
	#APP
	#NO_APP
	mov	qword ptr [rbp - 8], rax
	jmp	.LBB5_3
.LBB5_2:                                # %.5.else
	jmp	.LBB5_3
.LBB5_3:                                # %.5.endif
	mov	eax, 16
	mov	qword ptr [rbp - 56], rax       # 8-byte Spill
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 56]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, qword ptr [rbp - 8]
	mov	edx, dword ptr [rdx + 60]
	mov	dword ptr [rcx], edx
	mov	ecx, dword ptr [rcx]
                                        # kill: def $rcx killed $ecx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 56]       # 8-byte Reload
	mov	rdx, rsp
	mov	qword ptr [rdx], rcx
	mov	rcx, qword ptr [rdx]
	mov	r8, qword ptr [rbp - 8]
	add	rcx, r8
	mov	qword ptr [rdx], rcx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 56]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, qword ptr [rdx]
	mov	edx, dword ptr [rdx + 136]
	mov	dword ptr [rcx], edx
	mov	ecx, dword ptr [rcx]
                                        # kill: def $rcx killed $ecx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 56]       # 8-byte Reload
	mov	rdx, rsp
	mov	r8, rdx
	mov	qword ptr [rbp - 64], r8        # 8-byte Spill
	mov	qword ptr [rdx], rcx
	mov	rcx, qword ptr [rdx]
	mov	r8, qword ptr [rbp - 8]
	add	rcx, r8
	mov	qword ptr [rdx], rcx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 56]       # 8-byte Reload
	mov	rcx, rsp
	mov	r8, rcx
	mov	qword ptr [rbp - 48], r8        # 8-byte Spill
	mov	r8, qword ptr [rdx]
	mov	r8d, dword ptr [r8 + 24]
	mov	dword ptr [rcx], r8d
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 56]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, qword ptr [rdx]
	mov	edx, dword ptr [rdx + 32]
	mov	dword ptr [rcx], edx
	mov	ecx, dword ptr [rcx]
	mov	edx, ecx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 48]       # 8-byte Reload
	mov	rcx, rsp
	mov	qword ptr [rbp - 40], rcx       # 8-byte Spill
	mov	qword ptr [rcx], rdx
	mov	rdx, qword ptr [rcx]
	add	rdx, qword ptr [rbp - 8]
	mov	qword ptr [rcx], rdx
	mov	ecx, dword ptr [rax]
                                        # kill: def $rcx killed $ecx
	sub	rcx, 1
                                        # kill: def $ecx killed $ecx killed $rcx
	mov	dword ptr [rax], ecx
	cmp	dword ptr [rax], 0
	jbe	.LBB5_5
.LBB5_4:                                # %loop_5
                                        # =>This Inner Loop Header: Depth=1
	mov	rdx, qword ptr [rbp - 48]       # 8-byte Reload
	mov	rcx, qword ptr [rbp - 40]       # 8-byte Reload
	mov	eax, 16
	mov	qword ptr [rbp - 88], rax       # 8-byte Spill
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 88]       # 8-byte Reload
	mov	r8, rsp
	mov	rcx, qword ptr [rcx]
	mov	edx, dword ptr [rdx]
                                        # kill: def $rdx killed $edx
	mov	ecx, dword ptr [rcx + 4*rdx]
	mov	dword ptr [r8], ecx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 88]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, rcx
	mov	qword ptr [rbp - 80], rdx       # 8-byte Spill
	mov	rdx, qword ptr [rbp - 8]
	mov	r8d, dword ptr [r8]
                                        # kill: def $r8 killed $r8d
	add	rdx, r8
	mov	qword ptr [rcx], rdx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 80]       # 8-byte Reload
	mov	rcx, rsp
	mov	qword ptr [rbp - 72], rcx       # 8-byte Spill
	mov	rcx, qword ptr [rax]
	sub	rsp, 32
	call	compute_function_hash
	mov	ecx, dword ptr [rbp - 12]       # 4-byte Reload
	add	rsp, 32
	mov	edx, eax
	mov	rax, qword ptr [rbp - 72]       # 8-byte Reload
	mov	dword ptr [rax], edx
	cmp	dword ptr [rax], ecx
	je	.LBB5_6
	jmp	.LBB5_7
.LBB5_5:                                # %loop_after_5
	xor	eax, eax
                                        # kill: def $rax killed $eax
	mov	rsp, rbp
	pop	rbp
	ret
.LBB5_6:                                # %loop_5.if
	mov	rdx, qword ptr [rbp - 64]       # 8-byte Reload
	mov	r9, qword ptr [rbp - 48]        # 8-byte Reload
	mov	eax, 16
	mov	qword ptr [rbp - 96], rax       # 8-byte Spill
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	rcx, rsp
	mov	r8, qword ptr [rdx]
	mov	r8d, dword ptr [r8 + 36]
	mov	dword ptr [rcx], r8d
	mov	ecx, dword ptr [rcx]
	mov	r8d, ecx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	rcx, rsp
	mov	qword ptr [rcx], r8
	mov	r8, qword ptr [rcx]
	mov	r10, qword ptr [rbp - 8]
	add	r8, r10
	mov	qword ptr [rcx], r8
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	r8, rsp
	mov	rcx, qword ptr [rcx]
	mov	r9d, dword ptr [r9]
                                        # kill: def $r9 killed $r9d
	mov	cx, word ptr [rcx + 2*r9]
	mov	word ptr [r8], cx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, qword ptr [rdx]
	mov	edx, dword ptr [rdx + 28]
	mov	dword ptr [rcx], edx
	mov	ecx, dword ptr [rcx]
                                        # kill: def $rcx killed $ecx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	rdx, rsp
	mov	qword ptr [rdx], rcx
	mov	rcx, qword ptr [rdx]
	mov	r9, qword ptr [rbp - 8]
	add	rcx, r9
	mov	qword ptr [rdx], rcx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, qword ptr [rdx]
	movzx	r8d, word ptr [r8]
                                        # kill: def $r8 killed $r8d
	mov	edx, dword ptr [rdx + 4*r8]
	mov	dword ptr [rcx], edx
	mov	ecx, dword ptr [rcx]
                                        # kill: def $rcx killed $ecx
	call	__chkstk
	sub	rsp, rax
	mov	rax, rsp
	mov	qword ptr [rax], rcx
	mov	rcx, qword ptr [rax]
	add	rcx, qword ptr [rbp - 8]
	mov	qword ptr [rax], rcx
	mov	rax, qword ptr [rax]
	mov	rsp, rbp
	pop	rbp
	ret
.LBB5_7:                                # %loop_5.else
                                        #   in Loop: Header=BB5_4 Depth=1
	jmp	.LBB5_8
.LBB5_8:                                # %loop_5.endif
                                        #   in Loop: Header=BB5_4 Depth=1
	mov	rax, qword ptr [rbp - 48]       # 8-byte Reload
	mov	ecx, dword ptr [rax]
                                        # kill: def $rcx killed $ecx
	sub	rcx, 1
                                        # kill: def $ecx killed $ecx killed $rcx
	mov	dword ptr [rax], ecx
	cmp	dword ptr [rax], 0
	ja	.LBB5_4
	jmp	.LBB5_5
	.seh_endproc
                                        # -- End function
	.def	main;
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
	mov	byte ptr [rsp + 55], 0
	mov	byte ptr [rsp + 54], 0
	mov	byte ptr [rsp + 53], 0
	mov	byte ptr [rsp + 52], 0
	mov	byte ptr [rsp + 51], 0
	mov	byte ptr [rsp + 50], 0
	mov	byte ptr [rsp + 49], 0
	mov	byte ptr [rsp + 48], 0
	mov	byte ptr [rsp + 47], 0
	mov	byte ptr [rsp + 46], 0
	mov	byte ptr [rsp + 45], 0
	mov	byte ptr [rsp + 45], 117
	mov	byte ptr [rsp + 46], 115
	mov	byte ptr [rsp + 47], 101
	mov	byte ptr [rsp + 48], 114
	mov	byte ptr [rsp + 49], 51
	mov	byte ptr [rsp + 50], 50
	mov	byte ptr [rsp + 51], 46
	mov	byte ptr [rsp + 52], 100
	mov	byte ptr [rsp + 53], 108
	mov	byte ptr [rsp + 54], 108
	mov	byte ptr [rsp + 55], 0
	mov	byte ptr [rsp + 44], 0
	mov	byte ptr [rsp + 43], 108
	mov	byte ptr [rsp + 42], 108
	mov	byte ptr [rsp + 41], 100
	mov	byte ptr [rsp + 40], 46
	mov	byte ptr [rsp + 39], 50
	mov	byte ptr [rsp + 38], 51
	mov	byte ptr [rsp + 37], 108
	mov	byte ptr [rsp + 36], 101
	mov	byte ptr [rsp + 35], 110
	mov	byte ptr [rsp + 34], 114
	mov	byte ptr [rsp + 33], 101
	mov	byte ptr [rsp + 32], 107
	lea	r8, [rsp + 32]
	mov	ecx, 3960360590
	mov	edx, 1848363543
	call	find_function
	mov	rdx, rax
	lea	rcx, [rsp + 45]
	call	call_LoadLibraryA
	xor	eax, eax
                                        # kill: def $rax killed $eax
	add	rsp, 56
	ret
	.seh_endproc
                                        # -- End function
	.def	call_MessageBoxA;
	.scl	2;
	.type	32;
	.endef
	.globl	call_MessageBoxA                # -- Begin function call_MessageBoxA
	.p2align	4, 0x90
call_MessageBoxA:                       # @call_MessageBoxA
.seh_proc call_MessageBoxA
# %bb.0:                                # %.7
	sub	rsp, 16
	.seh_stackalloc 16
	.seh_endprologue
	mov	rax, qword ptr [rsp + 56]
	mov	qword ptr [rsp], rax            # 8-byte Spill
	mov	qword ptr [rsp + 8], 0
	#APP
	#NO_APP
	#APP
	mov	rsi, rsp
	push	qword ptr [rsi + 48]
	push	qword ptr [rsi + 40]
	push	qword ptr [rsi + 32]
	push	qword ptr [rsi + 24]
	push	rsi
	call	rax
	pop	rsi
	pop	rsi
	pop	rsi
	pop	rsi
	pop	rsi
	#NO_APP
	#APP
	#NO_APP
	mov	rcx, rax
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	mov	qword ptr [rsp + 8], rcx
	add	rsp, 16
	ret
	.seh_endproc
                                        # -- End function
	.def	call_LoadLibraryA;
	.scl	2;
	.type	32;
	.endef
	.globl	call_LoadLibraryA               # -- Begin function call_LoadLibraryA
	.p2align	4, 0x90
call_LoadLibraryA:                      # @call_LoadLibraryA
.seh_proc call_LoadLibraryA
# %bb.0:                                # %.4
	sub	rsp, 16
	.seh_stackalloc 16
	.seh_endprologue
	mov	rax, rdx
	mov	qword ptr [rsp], rax            # 8-byte Spill
	mov	qword ptr [rsp + 8], 0
	#APP
	#NO_APP
	#APP
	mov	rsi, rsp
	push	qword ptr [rsi + 24]
	push	rsi
	call	rax
	pop	rsi
	pop	rsi
	#NO_APP
	#APP
	#NO_APP
	mov	rcx, rax
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	mov	qword ptr [rsp + 8], rcx
	add	rsp, 16
	ret
	.seh_endproc
                                        # -- End function
	.addrsig
	.addrsig_sym to_lowercase
	.addrsig_sym compute_function_hash
	.addrsig_sym find_actual_dll_name
	.addrsig_sym compute_module_hash
	.addrsig_sym find_module_base
	.addrsig_sym find_function
	.addrsig_sym call_LoadLibraryA
