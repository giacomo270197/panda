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
	je	LBB2_3
	jmp	LBB2_4
LBB2_2:                                 # %loop_after_3
	xor	eax, eax
	mov	esp, ebp
	pop	ebp
	ret
LBB2_3:                                 # %loop_3.if
	mov	eax, dword ptr [ebp - 8]
	mov	esp, ebp
	pop	ebp
	ret
LBB2_4:                                 # %loop_3.else
                                        #   in Loop: Header=BB2_1 Depth=1
	jmp	LBB2_5
LBB2_5:                                 # %loop_3.endif
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
# %bb.0:                                # %.4
	push	ebp
	mov	ebp, esp
	push	esi
	sub	esp, 24
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [ebp + 8]
	mov	ecx, dword ptr [ebp + 12]
	sub	esp, 4
	mov	eax, esp
	mov	dword ptr [eax], ecx
	call	_find_module_base
	add	esp, 4
	mov	dword ptr [ebp - 8], eax
	mov	eax, dword ptr [ebp - 8]
	mov	eax, dword ptr [eax + 60]
	mov	dword ptr [ebp - 12], eax
	mov	eax, dword ptr [ebp - 12]
	mov	ecx, dword ptr [ebp - 8]
	add	eax, ecx
	mov	dword ptr [ebp - 12], eax
	mov	eax, dword ptr [ebp - 12]
	mov	eax, dword ptr [eax + 120]
	mov	dword ptr [ebp - 16], eax
	mov	eax, dword ptr [ebp - 16]
	mov	ecx, dword ptr [ebp - 8]
	add	eax, ecx
	mov	dword ptr [ebp - 16], eax
	mov	eax, dword ptr [ebp - 16]
	mov	eax, dword ptr [eax + 24]
	mov	dword ptr [ebp - 20], eax
	mov	eax, dword ptr [ebp - 16]
	mov	eax, dword ptr [eax + 32]
	mov	dword ptr [ebp - 24], eax
	mov	eax, dword ptr [ebp - 24]
	mov	ecx, dword ptr [ebp - 8]
	add	eax, ecx
	mov	dword ptr [ebp - 24], eax
	mov	eax, dword ptr [ebp - 20]
	dec	eax
	mov	dword ptr [ebp - 20], eax
	cmp	dword ptr [ebp - 20], 0
	jbe	LBB3_2
LBB3_1:                                 # %loop_4
                                        # =>This Inner Loop Header: Depth=1
	push	eax
	mov	ecx, esp
	mov	eax, ecx
	mov	esi, dword ptr [ebp - 20]
	mov	edx, dword ptr [ebp - 24]
	lea	edx, [edx + 4*esi]
	mov	dword ptr [ecx], edx
	mov	edx, dword ptr [ebp - 8]
	mov	esi, dword ptr [ecx]
	mov	esi, dword ptr [esi]
	add	edx, esi
	mov	dword ptr [ecx], edx
	push	eax
	mov	ecx, esp
	mov	dword ptr [ebp - 28], ecx       # 4-byte Spill
	mov	eax, dword ptr [eax]
	sub	esp, 4
	mov	dword ptr [esp], eax
	call	_compute_function_hash
	add	esp, 4
	mov	ecx, eax
	mov	eax, dword ptr [ebp - 28]       # 4-byte Reload
	mov	dword ptr [eax], ecx
	mov	eax, dword ptr [eax]
	cmp	eax, dword ptr [ebp + 8]
	je	LBB3_3
	jmp	LBB3_4
LBB3_2:                                 # %loop_after_4
	xor	eax, eax
	lea	esp, [ebp - 4]
	pop	esi
	pop	ebp
	ret
LBB3_3:                                 # %loop_4.if
	push	eax
	mov	eax, esp
	mov	ecx, dword ptr [ebp - 16]
	mov	ecx, dword ptr [ecx + 36]
	mov	dword ptr [eax], ecx
	mov	ecx, dword ptr [eax]
	mov	edx, dword ptr [ebp - 8]
	add	ecx, edx
	mov	dword ptr [eax], ecx
	push	eax
	mov	edx, esp
	mov	ecx, dword ptr [ebp - 20]
	mov	eax, dword ptr [eax]
	mov	ax, word ptr [eax + 2*ecx]
	mov	word ptr [edx], ax
	push	eax
	mov	ecx, esp
	mov	eax, dword ptr [ebp - 16]
	mov	eax, dword ptr [eax + 28]
	mov	dword ptr [ecx], eax
	mov	eax, dword ptr [ecx]
	mov	esi, dword ptr [ebp - 8]
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
	add	ecx, dword ptr [ebp - 8]
	mov	dword ptr [eax], ecx
	mov	eax, dword ptr [eax]
	lea	esp, [ebp - 4]
	pop	esi
	pop	ebp
	ret
LBB3_4:                                 # %loop_4.else
                                        #   in Loop: Header=BB3_1 Depth=1
	jmp	LBB3_5
LBB3_5:                                 # %loop_4.endif
                                        #   in Loop: Header=BB3_1 Depth=1
	mov	eax, dword ptr [ebp - 20]
	dec	eax
	mov	dword ptr [ebp - 20], eax
	cmp	dword ptr [ebp - 20], 0
	ja	LBB3_1
	jmp	LBB3_2
                                        # -- End function
	.def	_main;
	.scl	2;
	.type	32;
	.endef
	.globl	_main                           # -- Begin function main
	.p2align	4, 0x90
_main:                                  # @main
# %bb.0:                                # %.2
	sub	esp, 20
	mov	dword ptr [esp + 16], 1848363543
	mov	dword ptr [esp + 12], -334606706
	mov	ecx, dword ptr [esp + 12]
	mov	eax, dword ptr [esp + 16]
	mov	dword ptr [esp], ecx
	mov	dword ptr [esp + 4], eax
	call	_find_function
	mov	dword ptr [esp + 8], eax
	mov	eax, dword ptr [esp + 8]
	add	esp, 20
	ret
                                        # -- End function
	.addrsig
	.addrsig_sym _compute_function_hash
	.addrsig_sym _compute_module_hash
	.addrsig_sym _find_module_base
	.addrsig_sym _find_function
