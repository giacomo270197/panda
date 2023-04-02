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
	sub	esp, 12
	mov	eax, dword ptr [esp + 16]
	mov	dword ptr [esp], eax            # 4-byte Spill
	mov	dword ptr [esp + 8], 0
	mov	byte ptr [esp + 7], 0
	movzx	ecx, byte ptr [esp + 7]
	add	eax, ecx
	mov	al, byte ptr [eax]
	mov	byte ptr [esp + 6], al
	cmp	byte ptr [esp + 6], 0
	je	LBB0_2
LBB0_1:                                 # %loop_1
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [esp]            # 4-byte Reload
	mov	ecx, dword ptr [esp + 8]
	rol	ecx, 19
	mov	dword ptr [esp + 8], ecx
	mov	ecx, dword ptr [esp + 8]
	movzx	edx, byte ptr [esp + 6]
	add	ecx, edx
	mov	dword ptr [esp + 8], ecx
	mov	cl, byte ptr [esp + 7]
	inc	cl
	mov	byte ptr [esp + 7], cl
	movzx	ecx, byte ptr [esp + 7]
	add	eax, ecx
	mov	al, byte ptr [eax]
	mov	byte ptr [esp + 6], al
	cmp	byte ptr [esp + 6], 0
	jne	LBB0_1
LBB0_2:                                 # %loop_after_1
	mov	eax, dword ptr [esp + 8]
	add	esp, 12
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
	sub	esp, 12
	mov	eax, dword ptr [esp + 16]
	mov	dword ptr [esp], eax            # 4-byte Spill
	mov	dword ptr [esp + 8], 0
	mov	byte ptr [esp + 7], 0
	movzx	ecx, byte ptr [esp + 7]
	add	eax, ecx
	mov	ax, word ptr [eax]
	mov	word ptr [esp + 4], ax
	cmp	word ptr [esp + 4], 0
	je	LBB1_2
LBB1_1:                                 # %loop_2
                                        # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [esp]            # 4-byte Reload
	mov	ecx, dword ptr [esp + 8]
	rol	ecx, 19
	mov	dword ptr [esp + 8], ecx
	mov	ecx, dword ptr [esp + 8]
	movzx	edx, word ptr [esp + 4]
	add	ecx, edx
	mov	dword ptr [esp + 8], ecx
	mov	cl, byte ptr [esp + 7]
	add	cl, 2
	mov	byte ptr [esp + 7], cl
	movzx	ecx, byte ptr [esp + 7]
	add	eax, ecx
	mov	ax, word ptr [eax]
	mov	word ptr [esp + 4], ax
	cmp	word ptr [esp + 4], 0
	jne	LBB1_1
LBB1_2:                                 # %loop_after_2
	mov	eax, dword ptr [esp + 8]
	add	esp, 12
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
	sub	esp, 24
	mov	eax, dword ptr [ebp + 8]
	mov	dword ptr [ebp - 20], eax       # 4-byte Spill
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
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax]
	mov	dword ptr [ebp - 4], eax
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax + 8]
	mov	dword ptr [ebp - 8], eax
	mov	eax, dword ptr [ebp - 4]
	add	eax, 32
	mov	eax, dword ptr [eax]
	mov	dword ptr [ebp - 12], eax
	cmp	dword ptr [ebp - 12], 0
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
	push	eax
	mov	eax, esp
	mov	dword ptr [ebp - 24], eax       # 4-byte Spill
	mov	eax, dword ptr [ebp - 12]
	sub	esp, 4
	mov	dword ptr [esp], eax
	call	_compute_module_hash
	mov	ecx, dword ptr [ebp - 20]       # 4-byte Reload
	add	esp, 4
	mov	edx, eax
	mov	eax, dword ptr [ebp - 24]       # 4-byte Reload
	mov	dword ptr [eax], edx
	cmp	dword ptr [eax], ecx
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
	sub	esp, 32
	mov	eax, dword ptr [ebp + 16]
	mov	dword ptr [ebp - 24], eax       # 4-byte Spill
	mov	eax, dword ptr [ebp + 12]
	mov	ecx, dword ptr [ebp + 8]
	mov	dword ptr [ebp - 20], ecx       # 4-byte Spill
	sub	esp, 4
	mov	dword ptr [esp], eax
	call	_find_module_base
	add	esp, 4
	mov	dword ptr [ebp - 16], eax
	cmp	dword ptr [ebp - 16], 0
	jne	LBB3_2
# %bb.1:                                # %.5.if
	mov	ebx, dword ptr [ebp - 24]       # 4-byte Reload
	push	eax
	mov	eax, esp
	mov	dword ptr [ebp - 28], eax       # 4-byte Spill
	sub	esp, 12
	mov	dword ptr [esp], -334606706
	mov	dword ptr [esp + 4], 1848363543
	mov	dword ptr [esp + 8], ebx
	call	_find_function
	add	esp, 12
	mov	ecx, eax
	mov	eax, dword ptr [ebp - 28]       # 4-byte Reload
	mov	dword ptr [eax], ecx
	#APP
	#NO_APP
	#APP
	push	ebx
	#NO_APP
	mov	eax, dword ptr [eax]
	#APP
	#NO_APP
	#APP
	call	eax
	#NO_APP
	#APP
	#NO_APP
	mov	dword ptr [ebp - 16], eax
	jmp	LBB3_3
LBB3_2:                                 # %.5.else
	jmp	LBB3_3
LBB3_3:                                 # %.5.endif
	push	eax
	mov	eax, esp
	mov	ecx, dword ptr [ebp - 16]
	mov	ecx, dword ptr [ecx + 60]
	mov	dword ptr [eax], ecx
	mov	ecx, dword ptr [eax]
	mov	edx, dword ptr [ebp - 16]
	add	ecx, edx
	mov	dword ptr [eax], ecx
	push	eax
	mov	esi, esp
	mov	ecx, esi
	mov	dword ptr [ebp - 40], ecx       # 4-byte Spill
	mov	eax, dword ptr [eax]
	mov	eax, dword ptr [eax + 120]
	mov	dword ptr [esi], eax
	mov	eax, dword ptr [esi]
	mov	ecx, dword ptr [ebp - 16]
	add	eax, ecx
	mov	dword ptr [esi], eax
	push	eax
	mov	ecx, esp
	mov	eax, ecx
	mov	dword ptr [ebp - 36], eax       # 4-byte Spill
	mov	edx, dword ptr [esi]
	mov	edx, dword ptr [edx + 24]
	mov	dword ptr [ecx], edx
	push	eax
	mov	edx, esp
	mov	edi, edx
	mov	dword ptr [ebp - 32], edi       # 4-byte Spill
	mov	esi, dword ptr [esi]
	mov	esi, dword ptr [esi + 32]
	mov	dword ptr [edx], esi
	mov	esi, dword ptr [edx]
	mov	edi, dword ptr [ebp - 16]
	add	esi, edi
	mov	dword ptr [edx], esi
	mov	ecx, dword ptr [ecx]
	dec	ecx
	mov	dword ptr [eax], ecx
	cmp	dword ptr [eax], 0
	jbe	LBB3_5
LBB3_4:                                 # %loop_4
                                        # =>This Inner Loop Header: Depth=1
	mov	edx, dword ptr [ebp - 32]       # 4-byte Reload
	mov	esi, dword ptr [ebp - 36]       # 4-byte Reload
	push	eax
	mov	ecx, esp
	mov	eax, ecx
	mov	esi, dword ptr [esi]
	mov	edx, dword ptr [edx]
	lea	edx, [edx + 4*esi]
	mov	dword ptr [ecx], edx
	mov	edx, dword ptr [ebp - 16]
	mov	esi, dword ptr [ecx]
	mov	esi, dword ptr [esi]
	add	edx, esi
	mov	dword ptr [ecx], edx
	push	eax
	mov	ecx, esp
	mov	dword ptr [ebp - 44], ecx       # 4-byte Spill
	mov	eax, dword ptr [eax]
	sub	esp, 4
	mov	dword ptr [esp], eax
	call	_compute_function_hash
	mov	ecx, dword ptr [ebp - 20]       # 4-byte Reload
	add	esp, 4
	mov	edx, eax
	mov	eax, dword ptr [ebp - 44]       # 4-byte Reload
	mov	dword ptr [eax], edx
	cmp	dword ptr [eax], ecx
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
	mov	eax, dword ptr [ebp - 40]       # 4-byte Reload
	mov	esi, dword ptr [ebp - 36]       # 4-byte Reload
	push	eax
	mov	ecx, esp
	mov	edx, dword ptr [eax]
	mov	edx, dword ptr [edx + 36]
	mov	dword ptr [ecx], edx
	mov	edx, dword ptr [ecx]
	mov	edi, dword ptr [ebp - 16]
	add	edx, edi
	mov	dword ptr [ecx], edx
	push	eax
	mov	edx, esp
	mov	esi, dword ptr [esi]
	mov	ecx, dword ptr [ecx]
	mov	cx, word ptr [ecx + 2*esi]
	mov	word ptr [edx], cx
	push	eax
	mov	ecx, esp
	mov	eax, dword ptr [eax]
	mov	eax, dword ptr [eax + 28]
	mov	dword ptr [ecx], eax
	mov	eax, dword ptr [ecx]
	mov	esi, dword ptr [ebp - 16]
	add	eax, esi
	mov	dword ptr [ecx], eax
	push	eax
	mov	eax, esp
	movzx	edx, word ptr [edx]
	mov	ecx, dword ptr [ecx]
	lea	ecx, [ecx + 4*edx]
	mov	ecx, dword ptr [ecx]
	mov	dword ptr [eax], ecx
	mov	ecx, dword ptr [eax]
	add	ecx, dword ptr [ebp - 16]
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
	mov	eax, dword ptr [ebp - 36]       # 4-byte Reload
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
	push	edi
	push	esi
	sub	esp, 156
	mov	byte ptr [esp + 155], 0
	mov	byte ptr [esp + 154], 0
	mov	byte ptr [esp + 153], 0
	mov	byte ptr [esp + 152], 0
	mov	byte ptr [esp + 151], 0
	mov	byte ptr [esp + 150], 0
	mov	byte ptr [esp + 149], 0
	mov	byte ptr [esp + 148], 0
	mov	byte ptr [esp + 147], 0
	mov	byte ptr [esp + 146], 0
	mov	byte ptr [esp + 145], 0
	mov	byte ptr [esp + 144], 0
	mov	byte ptr [esp + 144], 110
	mov	byte ptr [esp + 145], 111
	mov	byte ptr [esp + 146], 116
	mov	byte ptr [esp + 147], 101
	mov	byte ptr [esp + 148], 112
	mov	byte ptr [esp + 149], 97
	mov	byte ptr [esp + 150], 100
	mov	byte ptr [esp + 151], 46
	mov	byte ptr [esp + 152], 101
	mov	byte ptr [esp + 153], 120
	mov	byte ptr [esp + 154], 101
	mov	byte ptr [esp + 155], 0
	mov	dword ptr [esp + 140], 0
	mov	dword ptr [esp + 136], 0
	mov	dword ptr [esp + 132], 0
	mov	dword ptr [esp + 128], 0
	mov	dword ptr [esp + 124], 0
	mov	dword ptr [esp + 120], 0
	mov	dword ptr [esp + 116], 0
	mov	dword ptr [esp + 112], 0
	mov	dword ptr [esp + 108], 0
	mov	dword ptr [esp + 104], 0
	mov	dword ptr [esp + 100], 0
	mov	dword ptr [esp + 96], 0
	mov	dword ptr [esp + 92], 0
	mov	dword ptr [esp + 88], 0
	mov	dword ptr [esp + 84], 0
	mov	dword ptr [esp + 80], 0
	mov	dword ptr [esp + 76], 0
	mov	dword ptr [esp + 76], 0
	mov	dword ptr [esp + 80], 0
	mov	dword ptr [esp + 84], 0
	mov	dword ptr [esp + 88], 0
	mov	dword ptr [esp + 92], 0
	mov	dword ptr [esp + 96], 0
	mov	dword ptr [esp + 100], 0
	mov	dword ptr [esp + 104], 0
	mov	dword ptr [esp + 108], 0
	mov	dword ptr [esp + 112], 0
	mov	dword ptr [esp + 116], 0
	mov	dword ptr [esp + 120], 0
	mov	dword ptr [esp + 124], 0
	mov	dword ptr [esp + 128], 0
	mov	dword ptr [esp + 132], 0
	mov	dword ptr [esp + 136], 0
	mov	dword ptr [esp + 140], 0
	mov	dword ptr [esp + 76], 68
	mov	dword ptr [esp + 72], 0
	mov	dword ptr [esp + 68], 0
	mov	dword ptr [esp + 64], 0
	mov	dword ptr [esp + 60], 0
	mov	dword ptr [esp + 60], 0
	mov	dword ptr [esp + 64], 0
	mov	dword ptr [esp + 68], 0
	mov	dword ptr [esp + 72], 0
	mov	byte ptr [esp + 59], 0
	mov	byte ptr [esp + 58], 108
	mov	byte ptr [esp + 57], 108
	mov	byte ptr [esp + 56], 100
	mov	byte ptr [esp + 55], 46
	mov	byte ptr [esp + 54], 50
	mov	byte ptr [esp + 53], 51
	mov	byte ptr [esp + 52], 108
	mov	byte ptr [esp + 51], 101
	mov	byte ptr [esp + 50], 110
	mov	byte ptr [esp + 49], 114
	mov	byte ptr [esp + 48], 101
	mov	byte ptr [esp + 47], 107
	lea	eax, [esp + 47]
	mov	dword ptr [esp], 380894834
	mov	dword ptr [esp + 4], -1880304065
	mov	dword ptr [esp + 8], eax
	call	_find_function
	lea	esi, [esp + 144]
	lea	edx, [esp + 76]
	lea	ecx, [esp + 60]
	xor	edi, edi
	mov	dword ptr [esp], 0
	mov	dword ptr [esp + 4], esi
	mov	dword ptr [esp + 8], 0
	mov	dword ptr [esp + 12], 0
	mov	dword ptr [esp + 16], 0
	mov	dword ptr [esp + 20], 0
	mov	dword ptr [esp + 24], 0
	mov	dword ptr [esp + 28], 0
	mov	dword ptr [esp + 32], edx
	mov	dword ptr [esp + 36], ecx
	mov	dword ptr [esp + 40], eax
	call	_call_CreateProcessA
	xor	eax, eax
	add	esp, 156
	pop	esi
	pop	edi
	ret
                                        # -- End function
	.def	_call_CreateProcessA;
	.scl	2;
	.type	32;
	.endef
	.globl	_call_CreateProcessA            # -- Begin function call_CreateProcessA
	.p2align	4, 0x90
_call_CreateProcessA:                   # @call_CreateProcessA
# %bb.0:                                # %.13
	sub	esp, 8
	mov	eax, dword ptr [esp + 52]
	mov	dword ptr [esp], eax            # 4-byte Spill
	mov	dword ptr [esp + 4], 0
	#APP
	#NO_APP
	#APP
	mov	esi, esp
	push	dword ptr [esi + 48]
	push	dword ptr [esi + 44]
	push	dword ptr [esi + 40]
	push	dword ptr [esi + 36]
	push	dword ptr [esi + 32]
	push	dword ptr [esi + 28]
	push	dword ptr [esi + 24]
	push	dword ptr [esi + 20]
	push	dword ptr [esi + 16]
	push	dword ptr [esi + 12]
	call	eax
	#NO_APP
	#APP
	#NO_APP
	mov	ecx, eax
	mov	eax, dword ptr [esp]            # 4-byte Reload
	mov	dword ptr [esp + 4], ecx
	add	esp, 8
	ret
                                        # -- End function
	.addrsig
	.addrsig_sym _compute_function_hash
	.addrsig_sym _compute_module_hash
	.addrsig_sym _find_module_base
	.addrsig_sym _find_function
	.addrsig_sym _call_CreateProcessA
