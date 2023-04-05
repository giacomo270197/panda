	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 0
	.intel_syntax noprefix
	.file	"example.ll"
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
	je	.LBB0_2
.LBB0_1:                                # %loop_1
                                        # =>This Inner Loop Header: Depth=1
	cmp	byte ptr [rsp + 15], 92
	je	.LBB0_3
	jmp	.LBB0_4
.LBB0_2:                                # %loop_after_1
	mov	rax, qword ptr [rsp + 16]
	add	rax, 2
	add	rsp, 32
	ret
.LBB0_3:                                # %loop_1.if
                                        #   in Loop: Header=BB0_1 Depth=1
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	add	rax, qword ptr [rsp + 24]
	mov	qword ptr [rsp + 16], rax
	jmp	.LBB0_5
.LBB0_4:                                # %loop_1.else
                                        #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_5
.LBB0_5:                                # %loop_1.endif
                                        #   in Loop: Header=BB0_1 Depth=1
	mov	rax, qword ptr [rsp]            # 8-byte Reload
	mov	rcx, qword ptr [rsp + 24]
	add	rcx, 2
	mov	qword ptr [rsp + 24], rcx
	add	rax, qword ptr [rsp + 24]
	mov	al, byte ptr [rax]
	mov	byte ptr [rsp + 15], al
	cmp	byte ptr [rsp + 15], 0
	jne	.LBB0_1
	jmp	.LBB0_2
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
	je	.LBB1_2
.LBB1_1:                                # %loop_2
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
	jne	.LBB1_1
.LBB1_2:                                # %loop_after_2
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
	jne	.LBB2_2
.LBB2_1:                                # %loop_3
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
	je	.LBB2_3
	jmp	.LBB2_4
.LBB2_2:                                # %loop_after_3
	xor	eax, eax
                                        # kill: def $rax killed $eax
	mov	rsp, rbp
	pop	rbp
	ret
.LBB2_3:                                # %loop_3.if
	mov	rax, qword ptr [rbp - 48]       # 8-byte Reload
	mov	rax, qword ptr [rax]
	mov	rax, qword ptr [rax + 48]
	mov	rsp, rbp
	pop	rbp
	ret
.LBB2_4:                                # %loop_3.else
                                        #   in Loop: Header=BB2_1 Depth=1
	jmp	.LBB2_5
.LBB2_5:                                # %loop_3.endif
                                        #   in Loop: Header=BB2_1 Depth=1
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 8], rax
	cmp	byte ptr [rbp - 9], 0
	je	.LBB2_1
	jmp	.LBB2_2
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
	sub	rsp, 64
	.seh_stackalloc 64
	lea	rbp, [rsp + 64]
	.seh_setframe rbp, 64
	.seh_endprologue
	mov	ecx, edx
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
	jbe	.LBB3_2
.LBB3_1:                                # %loop_4
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, 16
	mov	qword ptr [rbp - 64], rax       # 8-byte Spill
	call	__chkstk
	sub	rsp, rax
	mov	rax, qword ptr [rbp - 64]       # 8-byte Reload
	mov	rcx, rsp
	mov	rdx, rcx
	mov	r8, qword ptr [rbp - 56]
	mov	r9d, dword ptr [rbp - 44]
                                        # kill: def $r9 killed $r9d
	mov	r8d, dword ptr [r8 + 4*r9]
	mov	dword ptr [rcx], r8d
	call	__chkstk
	sub	rsp, rax
	mov	rax, rsp
	mov	rcx, qword ptr [rbp - 8]
	mov	edx, dword ptr [rdx]
                                        # kill: def $rdx killed $edx
	add	rcx, rdx
	mov	qword ptr [rax], rcx
	mov	eax, dword ptr [rbp - 44]
                                        # kill: def $rax killed $eax
	sub	rax, 1
                                        # kill: def $eax killed $eax killed $rax
	mov	dword ptr [rbp - 44], eax
	cmp	dword ptr [rbp - 44], 0
	ja	.LBB3_1
.LBB3_2:                                # %loop_after_4
	xor	eax, eax
                                        # kill: def $rax killed $eax
	mov	rsp, rbp
	pop	rbp
	ret
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
	xor	ecx, ecx
	call	find_function
	mov	qword ptr [rsp + 32], rax
	xor	eax, eax
	add	rsp, 56
	ret
	.seh_endproc
                                        # -- End function
	.addrsig
	.addrsig_sym find_actual_dll_name
	.addrsig_sym compute_module_hash
	.addrsig_sym find_module_base
	.addrsig_sym find_function
