	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 1
	.intel_syntax noprefix
	.file	"example.ll"
	.def	_compute_function_hash;
	.scl	2;
	.type	32;
	.endef
	.globl	_compute_function_hash          # -- Begin function compute_function_hash
	.p2align	4, 0x90
_compute_function_hash:                 # @compute_function_hash
# %bb.0:                                # %.3
	sub	esp, 8
	mov	eax, dword ptr [esp + 12]
	mov	dword ptr [esp + 4], 0
	mov	byte ptr [esp + 3], 0
	mov	eax, dword ptr [esp + 12]
	movzx	ecx, byte ptr [esp + 3]
	add	eax, ecx
	mov	al, byte ptr [eax]
	mov	byte ptr [esp + 2], al
	cmp	byte ptr [esp + 2], 0
	je	LBB0_2
LBB0_1:                                 # %loop_1
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [esp + 4]
	rol	eax, 19
	mov	dword ptr [esp + 4], eax
	mov	eax, dword ptr [esp + 4]
	movzx	ecx, byte ptr [esp + 2]
	add	eax, ecx
	mov	dword ptr [esp + 4], eax
	mov	al, byte ptr [esp + 3]
	inc	al
	mov	byte ptr [esp + 3], al
	mov	eax, dword ptr [esp + 12]
	movzx	ecx, byte ptr [esp + 3]
	add	eax, ecx
	mov	al, byte ptr [eax]
	mov	byte ptr [esp + 2], al
	cmp	byte ptr [esp + 2], 0
	jne	LBB0_1
LBB0_2:                                 # %loop_after_1
	mov	eax, dword ptr [esp + 4]
	add	esp, 8
	ret
                                        # -- End function
	.def	_compute_module_hash;
	.scl	2;
	.type	32;
	.endef
	.globl	_compute_module_hash            # -- Begin function compute_module_hash
	.p2align	4, 0x90
_compute_module_hash:                   # @compute_module_hash
# %bb.0:                                # %.3
	sub	esp, 8
	mov	eax, dword ptr [esp + 12]
	mov	dword ptr [esp + 4], 0
	mov	byte ptr [esp + 3], 0
	mov	eax, dword ptr [esp + 12]
	movzx	ecx, byte ptr [esp + 3]
	add	eax, ecx
	mov	ax, word ptr [eax]
	mov	word ptr [esp], ax
	cmp	word ptr [esp], 0
	je	LBB1_2
LBB1_1:                                 # %loop_2
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [esp + 4]
	rol	eax, 19
	mov	dword ptr [esp + 4], eax
	mov	eax, dword ptr [esp + 4]
	movzx	ecx, word ptr [esp]
	add	eax, ecx
	mov	dword ptr [esp + 4], eax
	mov	al, byte ptr [esp + 3]
	add	al, 2
	mov	byte ptr [esp + 3], al
	mov	eax, dword ptr [esp + 12]
	movzx	ecx, byte ptr [esp + 3]
	add	eax, ecx
	mov	ax, word ptr [eax]
	mov	word ptr [esp], ax
	cmp	word ptr [esp], 0
	jne	LBB1_1
LBB1_2:                                 # %loop_after_2
	mov	eax, dword ptr [esp + 4]
	add	esp, 8
	ret
                                        # -- End function
	.def	_find_module_base;
	.scl	2;
	.type	32;
	.endef
	.globl	_find_module_base               # -- Begin function find_module_base
	.p2align	4, 0x90
_find_module_base:                      # @find_module_base
# %bb.0:                                # %.3
	push	ebp
	mov	ebp, esp
	sub	esp, 20
	mov	eax, dword ptr [ebp + 8]
	mov	dword ptr [ebp - 4], 0
	mov	eax, dword ptr [ebp - 4]
	#APP
	#NO_APP
	#APP
	mov	eax, dword ptr fs:[48]
	#NO_APP
	#APP
	#NO_APP
	mov	dword ptr [ebp - 4], eax
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax + 12]
	mov	dword ptr [ebp - 4], eax
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax + 28]
	mov	dword ptr [ebp - 4], eax
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax + 8]
	mov	dword ptr [ebp - 8], eax
	mov	eax, dword ptr [ebp - 4]
	add	eax, 32
	mov	eax, dword ptr [eax]
	mov	dword ptr [ebp - 12], eax
	mov	byte ptr [ebp - 13], 0
	cmp	byte ptr [ebp - 13], 0
	jne	LBB2_2
LBB2_1:                                 # %loop_3
                                        # =>This Inner Loop Header: Depth=1
	cmp	dword ptr [ebp - 4], 0
	je	LBB2_3
	jmp	LBB2_4
LBB2_2:                                 # %loop_after_3
	xor	eax, eax
	mov	esp, ebp
	pop	ebp
	ret
LBB2_3:                                 # %loop_3.if
	xor	eax, eax
	mov	esp, ebp
	pop	ebp
	ret
LBB2_4:                                 # %loop_3.else
                                        #   in Loop: Header=BB2_1 Depth=1
	jmp	LBB2_5
LBB2_5:                                 # %loop_3.endif
                                        #   in Loop: Header=BB2_1 Depth=1
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax]
	mov	dword ptr [ebp - 4], eax
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax + 8]
	mov	dword ptr [ebp - 8], eax
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax + 32]
	mov	dword ptr [ebp - 12], eax
	push	eax
	mov	eax, esp
	mov	dword ptr [ebp - 20], eax       # 4-byte Spill
	mov	eax, dword ptr [ebp - 12]
	sub	esp, 4
	mov	dword ptr [esp], eax
	call	_compute_module_hash
	add	esp, 4
	mov	ecx, eax
	mov	eax, dword ptr [ebp - 20]       # 4-byte Reload
	mov	dword ptr [eax], ecx
	mov	eax, dword ptr [eax]
	cmp	eax, dword ptr [ebp + 8]
	jne	LBB2_7
# %bb.6:                                # %loop_3.endif.if
	mov	eax, dword ptr [ebp - 8]
	mov	esp, ebp
	pop	ebp
	ret
LBB2_7:                                 # %loop_3.endif.else
                                        #   in Loop: Header=BB2_1 Depth=1
	jmp	LBB2_8
LBB2_8:                                 # %loop_3.endif.endif
                                        #   in Loop: Header=BB2_1 Depth=1
	cmp	byte ptr [ebp - 13], 0
	je	LBB2_1
	jmp	LBB2_2
                                        # -- End function
	.def	_find_function;
	.scl	2;
	.type	32;
	.endef
	.globl	_find_function                  # -- Begin function find_function
	.p2align	4, 0x90
_find_function:                         # @find_function
# %bb.0:                                # %.5
	push	ebp
	mov	ebp, esp
	push	ebx
	push	edi
	push	esi
	and	esp, -8
	sub	esp, 32
	mov	esi, esp
	mov	eax, dword ptr [ebp + 16]
	mov	ecx, dword ptr [ebp + 12]
	mov	ecx, dword ptr [ebp + 8]
	mov	dword ptr [esi + 24], eax
	mov	eax, dword ptr [ebp + 12]
	sub	esp, 4
	mov	dword ptr [esp], eax
	call	_find_module_base
	add	esp, 4
	mov	dword ptr [esi + 20], eax
	cmp	dword ptr [esi + 20], 0
	jne	LBB3_2
# %bb.1:                                # %.5.if
	push	eax
	mov	eax, esp
	mov	dword ptr [esi + 16], eax       # 4-byte Spill
	mov	eax, dword ptr [esi + 24]
	sub	esp, 12
	mov	dword ptr [esp], -334606706
	mov	dword ptr [esp + 4], -1880304065
	mov	dword ptr [esp + 8], eax
	call	_find_function
	add	esp, 12
	mov	ecx, eax
	mov	eax, dword ptr [esi + 16]       # 4-byte Reload
	mov	dword ptr [eax], ecx
	mov	ebx, dword ptr [esi + 24]
	#APP
	#NO_APP
	#APP
	push	ebx
	#NO_APP
	mov	eax, dword ptr [eax]
	#APP
	#NO_APP
	#APP
	call	dword ptr [eax]
	#NO_APP
	#APP
	#NO_APP
	mov	dword ptr [esi + 20], eax
	jmp	LBB3_3
LBB3_2:                                 # %.5.else
	jmp	LBB3_3
LBB3_3:                                 # %.5.endif
	push	eax
	mov	eax, esp
	mov	ecx, dword ptr [esi + 20]
	mov	ecx, dword ptr [ecx + 60]
	mov	dword ptr [eax], ecx
	mov	ecx, dword ptr [eax]
	mov	edx, dword ptr [esi + 20]
	add	ecx, edx
	mov	dword ptr [eax], ecx
	push	eax
	mov	edi, esp
	mov	ecx, edi
	mov	dword ptr [esi + 4], ecx        # 4-byte Spill
	mov	eax, dword ptr [eax]
	mov	eax, dword ptr [eax + 120]
	mov	dword ptr [edi], eax
	mov	eax, dword ptr [edi]
	mov	ecx, dword ptr [esi + 20]
	add	eax, ecx
	mov	dword ptr [edi], eax
	push	eax
	mov	ecx, esp
	mov	eax, ecx
	mov	dword ptr [esi + 8], eax        # 4-byte Spill
	mov	edx, dword ptr [edi]
	mov	edx, dword ptr [edx + 24]
	mov	dword ptr [ecx], edx
	push	eax
	mov	edx, esp
	mov	ebx, edx
	mov	dword ptr [esi + 12], ebx       # 4-byte Spill
	mov	edi, dword ptr [edi]
	mov	edi, dword ptr [edi + 32]
	mov	dword ptr [edx], edi
	mov	edi, dword ptr [edx]
	mov	ebx, dword ptr [esi + 20]
	add	edi, ebx
	mov	dword ptr [edx], edi
	mov	ecx, dword ptr [ecx]
	dec	ecx
	mov	dword ptr [eax], ecx
	cmp	dword ptr [eax], 0
	jbe	LBB3_5
LBB3_4:                                 # %loop_4
                                        # =>This Inner Loop Header: Depth=1
	mov	edx, dword ptr [esi + 12]       # 4-byte Reload
	mov	edi, dword ptr [esi + 8]        # 4-byte Reload
	push	eax
	mov	ecx, esp
	mov	eax, ecx
	mov	edi, dword ptr [edi]
	mov	edx, dword ptr [edx]
	lea	edx, [edx + 4*edi]
	mov	dword ptr [ecx], edx
	mov	edx, dword ptr [esi + 20]
	mov	edi, dword ptr [ecx]
	mov	edi, dword ptr [edi]
	add	edx, edi
	mov	dword ptr [ecx], edx
	push	eax
	mov	ecx, esp
	mov	dword ptr [esi], ecx            # 4-byte Spill
	mov	eax, dword ptr [eax]
	sub	esp, 4
	mov	dword ptr [esp], eax
	call	_compute_function_hash
	add	esp, 4
	mov	ecx, eax
	mov	eax, dword ptr [esi]            # 4-byte Reload
	mov	dword ptr [eax], ecx
	mov	eax, dword ptr [eax]
	cmp	eax, dword ptr [ebp + 8]
	je	LBB3_6
	jmp	LBB3_7
LBB3_5:                                 # %loop_after_4
	xor	eax, eax
	lea	esp, [ebp - 12]
	pop	esi
	pop	edi
	pop	ebx
	pop	ebp
	ret
LBB3_6:                                 # %loop_4.if
	mov	eax, dword ptr [esi + 4]        # 4-byte Reload
	mov	edi, dword ptr [esi + 8]        # 4-byte Reload
	push	eax
	mov	ecx, esp
	mov	edx, dword ptr [eax]
	mov	edx, dword ptr [edx + 36]
	mov	dword ptr [ecx], edx
	mov	edx, dword ptr [ecx]
	mov	ebx, dword ptr [esi + 20]
	add	edx, ebx
	mov	dword ptr [ecx], edx
	push	eax
	mov	edx, esp
	mov	edi, dword ptr [edi]
	mov	ecx, dword ptr [ecx]
	mov	cx, word ptr [ecx + 2*edi]
	mov	word ptr [edx], cx
	push	eax
	mov	ecx, esp
	mov	eax, dword ptr [eax]
	mov	eax, dword ptr [eax + 28]
	mov	dword ptr [ecx], eax
	mov	eax, dword ptr [ecx]
	mov	edi, dword ptr [esi + 20]
	add	eax, edi
	mov	dword ptr [ecx], eax
	push	eax
	mov	eax, esp
	movzx	edx, word ptr [edx]
	mov	ecx, dword ptr [ecx]
	lea	ecx, [ecx + 4*edx]
	mov	ecx, dword ptr [ecx]
	mov	dword ptr [eax], ecx
	mov	ecx, dword ptr [eax]
	add	ecx, dword ptr [esi + 20]
	mov	dword ptr [eax], ecx
	mov	eax, dword ptr [eax]
	lea	esp, [ebp - 12]
	pop	esi
	pop	edi
	pop	ebx
	pop	ebp
	ret
LBB3_7:                                 # %loop_4.else
                                        #   in Loop: Header=BB3_4 Depth=1
	jmp	LBB3_8
LBB3_8:                                 # %loop_4.endif
                                        #   in Loop: Header=BB3_4 Depth=1
	mov	eax, dword ptr [esi + 8]        # 4-byte Reload
	mov	ecx, dword ptr [eax]
	dec	ecx
	mov	dword ptr [eax], ecx
	cmp	dword ptr [eax], 0
	ja	LBB3_4
	jmp	LBB3_5
                                        # -- End function
	.def	_main;
	.scl	2;
	.type	32;
	.endef
	.globl	_main                           # -- Begin function main
	.p2align	4, 0x90
_main:                                  # @main
# %bb.0:                                # %.2
	sub	esp, 40
	mov	dword ptr [esp + 36], 1848363543
	mov	dword ptr [esp + 32], -334606706
	mov	byte ptr [esp + 31], 0
	mov	byte ptr [esp + 30], 0
	mov	byte ptr [esp + 29], 0
	mov	byte ptr [esp + 28], 0
	mov	byte ptr [esp + 27], 0
	mov	byte ptr [esp + 26], 0
	mov	byte ptr [esp + 25], 0
	mov	byte ptr [esp + 24], 0
	mov	byte ptr [esp + 23], 0
	mov	byte ptr [esp + 22], 0
	mov	byte ptr [esp + 21], 0
	mov	byte ptr [esp + 20], 0
	mov	byte ptr [esp + 19], 0
	mov	byte ptr [esp + 19], 107
	mov	byte ptr [esp + 20], 101
	mov	byte ptr [esp + 21], 114
	mov	byte ptr [esp + 22], 110
	mov	byte ptr [esp + 23], 101
	mov	byte ptr [esp + 24], 108
	mov	byte ptr [esp + 25], 51
	mov	byte ptr [esp + 26], 50
	mov	byte ptr [esp + 27], 46
	mov	byte ptr [esp + 28], 100
	mov	byte ptr [esp + 29], 108
	mov	byte ptr [esp + 30], 108
	mov	byte ptr [esp + 31], 0
	mov	ecx, dword ptr [esp + 36]
	lea	eax, [esp + 19]
	mov	dword ptr [esp], -334606706
	mov	dword ptr [esp + 4], ecx
	mov	dword ptr [esp + 8], eax
	call	_find_function
	mov	dword ptr [esp + 12], eax
	xor	eax, eax
	add	esp, 40
	ret
                                        # -- End function
	.addrsig
	.addrsig_sym _compute_function_hash
	.addrsig_sym _compute_module_hash
	.addrsig_sym _find_module_base
	.addrsig_sym _find_function
