	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 0
	.intel_syntax noprefix
	.file	"example.ll"
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
	je	.LBB0_2
.LBB0_1:                                # %loop_1
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
	jne	.LBB0_1
.LBB0_2:                                # %loop_after_1
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
	je	.LBB1_2
.LBB1_1:                                # %loop_2
                                        # =>This Inner Loop Header: Depth=1
	cmp	byte ptr [rsp + 15], 92
	je	.LBB1_3
	jmp	.LBB1_4
.LBB1_2:                                # %loop_after_2
	mov	rax, qword ptr [rsp + 16]
	add	rax, 2
	add	rsp, 32
	ret
.LBB1_3:                                # %loop_2.if
                                        #   in Loop: Header=BB1_1 Depth=1
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	add	rax, qword ptr [rsp + 24]
	mov	qword ptr [rsp + 16], rax
	jmp	.LBB1_5
.LBB1_4:                                # %loop_2.else
                                        #   in Loop: Header=BB1_1 Depth=1
	jmp	.LBB1_5
.LBB1_5:                                # %loop_2.endif
                                        #   in Loop: Header=BB1_1 Depth=1
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	mov	rcx, qword ptr [rsp + 24]
	add	rcx, 2
	mov	qword ptr [rsp + 24], rcx
	add	rax, qword ptr [rsp + 24]
	mov	al, byte ptr [rax]
	mov	byte ptr [rsp + 15], al
	cmp	byte ptr [rsp + 15], 0
	jne	.LBB1_1
	jmp	.LBB1_2
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
	cmp	word ptr [rsp + 40], 0
	je	.LBB2_2
.LBB2_1:                                # %loop_3
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
	jne	.LBB2_1
.LBB2_2:                                # %loop_after_3
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
	jne	.LBB3_2
.LBB3_1:                                # %loop_4
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, 16
	mov	qword ptr [rbp - 40], rax       # 8-byte Spill
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 40]       # 8-byte Reload
	mov	rdx, rsp
	mov	rcx, rdx
	mov	qword ptr [rbp - 48], rcx       # 8-byte Spill
	mov	rcx, qword ptr [rbp - 8]
	mov	rcx, qword ptr [rcx - 16]
	mov	qword ptr [rdx], rcx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 40]       # 8-byte Reload
	mov	rcx, rsp
	mov	r8, rcx
	mov	qword ptr [rbp - 32], r8        # 8-byte Spill
	mov	rdx, qword ptr [rdx]
	mov	rdx, qword ptr [rdx + 80]
	mov	qword ptr [rcx], rdx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 32]       # 8-byte Reload
	mov	rcx, rsp
	mov	qword ptr [rbp - 24], rcx       # 8-byte Spill
	mov	rcx, qword ptr [rax]
	sub	rsp, 32
	call	compute_module_hash
	mov	ecx, dword ptr [rbp - 16]       # 4-byte Reload
	add	rsp, 32
	mov	edx, eax
	mov	rax, qword ptr [rbp - 24]       # 8-byte Reload
	mov	dword ptr [rax], edx
	cmp	dword ptr [rax], ecx
	je	.LBB3_3
	jmp	.LBB3_4
.LBB3_2:                                # %loop_after_4
	xor	eax, eax
                                        # kill: def $rax killed $eax
	mov	rsp, rbp
	pop	rbp
	ret
.LBB3_3:                                # %loop_4.if
	mov	rax, qword ptr [rbp - 48]       # 8-byte Reload
	mov	rax, qword ptr [rax]
	mov	rax, qword ptr [rax + 48]
	mov	rsp, rbp
	pop	rbp
	ret
.LBB3_4:                                # %loop_4.else
                                        #   in Loop: Header=BB3_1 Depth=1
	jmp	.LBB3_5
.LBB3_5:                                # %loop_4.endif
                                        #   in Loop: Header=BB3_1 Depth=1
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 8], rax
	cmp	byte ptr [rbp - 9], 0
	je	.LBB3_1
	jmp	.LBB3_2
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
	mov	dword ptr [rbp - 64], edx       # 4-byte Spill
	mov	eax, ecx
	mov	ecx, dword ptr [rbp - 64]       # 4-byte Reload
	mov	dword ptr [rbp - 60], eax       # 4-byte Spill
	sub	rsp, 32
	call	find_module_base
	add	rsp, 32
	mov	qword ptr [rbp - 8], rax
	mov	rax, qword ptr [rbp - 8]
	mov	eax, dword ptr [rax + 60]
	mov	dword ptr [rbp - 12], eax
	mov	eax, dword ptr [rbp - 12]
                                        # kill: def $rax killed $eax
	mov	qword ptr [rbp - 24], rax
	mov	rax, qword ptr [rbp - 24]
	add	rax, qword ptr [rbp - 8]
	mov	qword ptr [rbp - 24], rax
	mov	rax, qword ptr [rbp - 24]
	mov	eax, dword ptr [rax + 136]
	mov	dword ptr [rbp - 28], eax
	mov	eax, dword ptr [rbp - 28]
                                        # kill: def $rax killed $eax
	mov	qword ptr [rbp - 40], rax
	mov	rax, qword ptr [rbp - 40]
	add	rax, qword ptr [rbp - 8]
	mov	qword ptr [rbp - 40], rax
	mov	rax, qword ptr [rbp - 40]
	mov	eax, dword ptr [rax + 24]
	mov	dword ptr [rbp - 44], eax
	mov	rax, qword ptr [rbp - 40]
	mov	eax, dword ptr [rax + 32]
	mov	dword ptr [rbp - 48], eax
	mov	eax, dword ptr [rbp - 48]
                                        # kill: def $rax killed $eax
	mov	qword ptr [rbp - 56], rax
	mov	rax, qword ptr [rbp - 56]
	add	rax, qword ptr [rbp - 8]
	mov	qword ptr [rbp - 56], rax
	mov	eax, dword ptr [rbp - 44]
                                        # kill: def $rax killed $eax
	sub	rax, 1
                                        # kill: def $eax killed $eax killed $rax
	mov	dword ptr [rbp - 44], eax
	cmp	dword ptr [rbp - 44], 0
	jbe	.LBB4_2
.LBB4_1:                                # %loop_5
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, 16
	mov	qword ptr [rbp - 88], rax       # 8-byte Spill
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 88]       # 8-byte Reload
	mov	r8, rsp
	mov	rcx, qword ptr [rbp - 56]
	mov	edx, dword ptr [rbp - 44]
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
	mov	ecx, dword ptr [rbp - 60]       # 4-byte Reload
	add	rsp, 32
	mov	edx, eax
	mov	rax, qword ptr [rbp - 72]       # 8-byte Reload
	mov	dword ptr [rax], edx
	cmp	dword ptr [rax], ecx
	je	.LBB4_3
	jmp	.LBB4_4
.LBB4_2:                                # %loop_after_5
	xor	eax, eax
                                        # kill: def $rax killed $eax
	mov	rsp, rbp
	pop	rbp
	ret
.LBB4_3:                                # %loop_5.if
	mov	eax, 16
	mov	qword ptr [rbp - 96], rax       # 8-byte Spill
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, qword ptr [rbp - 40]
	mov	edx, dword ptr [rdx + 36]
	mov	dword ptr [rcx], edx
	mov	ecx, dword ptr [rcx]
	mov	edx, ecx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	rcx, rsp
	mov	qword ptr [rcx], rdx
	mov	rdx, qword ptr [rcx]
	mov	r8, qword ptr [rbp - 8]
	add	rdx, r8
	mov	qword ptr [rcx], rdx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	r8, rsp
	mov	rcx, qword ptr [rcx]
	mov	edx, dword ptr [rbp - 44]
                                        # kill: def $rdx killed $edx
	mov	cx, word ptr [rcx + 2*rdx]
	mov	word ptr [r8], cx
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 96]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, qword ptr [rbp - 40]
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
.LBB4_4:                                # %loop_5.else
                                        #   in Loop: Header=BB4_1 Depth=1
	jmp	.LBB4_5
.LBB4_5:                                # %loop_5.endif
                                        #   in Loop: Header=BB4_1 Depth=1
	mov	eax, dword ptr [rbp - 44]
                                        # kill: def $rax killed $eax
	sub	rax, 1
                                        # kill: def $eax killed $eax killed $rax
	mov	dword ptr [rbp - 44], eax
	cmp	dword ptr [rbp - 44], 0
	ja	.LBB4_1
	jmp	.LBB4_2
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
	mov	dword ptr [rsp + 52], 1848363543
	mov	byte ptr [rsp + 51], 0
	mov	byte ptr [rsp + 50], 0
	mov	byte ptr [rsp + 49], 0
	mov	byte ptr [rsp + 48], 0
	mov	byte ptr [rsp + 47], 0
	mov	byte ptr [rsp + 46], 0
	mov	byte ptr [rsp + 45], 0
	mov	byte ptr [rsp + 44], 0
	mov	byte ptr [rsp + 43], 0
	mov	byte ptr [rsp + 43], 107
	mov	byte ptr [rsp + 44], 101
	mov	byte ptr [rsp + 45], 114
	mov	byte ptr [rsp + 46], 110
	mov	byte ptr [rsp + 47], 101
	mov	byte ptr [rsp + 48], 108
	mov	byte ptr [rsp + 49], 51
	mov	byte ptr [rsp + 50], 50
	mov	byte ptr [rsp + 51], 0
	mov	edx, dword ptr [rsp + 52]
	lea	r8, [rsp + 43]
	mov	ecx, 3960360590
	call	find_function
	mov	qword ptr [rsp + 32], rax
	xor	eax, eax
	add	rsp, 56
	ret
	.seh_endproc
                                        # -- End function
	.addrsig
	.addrsig_sym compute_function_hash
	.addrsig_sym find_actual_dll_name
	.addrsig_sym compute_module_hash
	.addrsig_sym find_module_base
	.addrsig_sym find_function
