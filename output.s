	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 1
	.intel_syntax noprefix
	.file	"example.ll"
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
	sub	esp, 16
	mov	eax, dword ptr [ebp + 12]
	mov	eax, dword ptr [ebp + 8]
	mov	eax, dword ptr [ebp + 8]
	mov	eax, dword ptr [eax + 60]
	mov	dword ptr [ebp - 4], eax
	mov	eax, dword ptr [ebp - 4]
	mov	ecx, dword ptr [ebp + 8]
	add	eax, ecx
	mov	dword ptr [ebp - 4], eax
	mov	eax, dword ptr [ebp - 4]
	mov	eax, dword ptr [eax + 120]
	mov	dword ptr [ebp - 8], eax
	mov	eax, dword ptr [ebp - 8]
	mov	ecx, dword ptr [ebp + 8]
	add	eax, ecx
	mov	dword ptr [ebp - 8], eax
	mov	eax, dword ptr [ebp - 8]
	mov	eax, dword ptr [eax + 24]
	mov	dword ptr [ebp - 12], eax
	mov	eax, dword ptr [ebp - 8]
	mov	eax, dword ptr [eax + 32]
	mov	dword ptr [ebp - 16], eax
	mov	eax, dword ptr [ebp - 16]
	mov	ecx, dword ptr [ebp + 8]
	add	eax, ecx
	mov	dword ptr [ebp - 16], eax
	mov	eax, dword ptr [ebp - 12]
	mov	ecx, 1
	sub	eax, ecx
	mov	dword ptr [ebp - 12], eax
	cmp	dword ptr [ebp - 12], 0
	jbe	LBB0_2
LBB0_1:                                 # %loop_1
                                        # =>This Inner Loop Header: Depth=1
	push	eax
	mov	eax, esp
	mov	ecx, dword ptr [ebp - 16]
	mov	edx, dword ptr [ebp - 12]
	lea	ecx, [ecx + 4*edx]
	mov	dword ptr [eax], ecx
	mov	ecx, dword ptr [ebp + 8]
	mov	edx, dword ptr [eax]
	mov	edx, dword ptr [edx]
	add	ecx, edx
	mov	dword ptr [eax], ecx
	mov	eax, dword ptr [ebp - 12]
	mov	ecx, 1
	sub	eax, ecx
	mov	dword ptr [ebp - 12], eax
	cmp	dword ptr [ebp - 12], 0
	ja	LBB0_1
LBB0_2:                                 # %loop_after_1
	mov	eax, dword ptr [ebp - 4]
	mov	esp, ebp
	pop	ebp
	ret
                                        # -- End function
	.def	_main;
	.scl	2;
	.type	32;
	.endef
	.globl	_main                           # -- Begin function main
	.p2align	4, 0x90
_main:                                  # @main
# %bb.0:                                # %.2
	push	ebp
	mov	ebp, esp
	sub	esp, 20
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
	mov	eax, dword ptr [eax + 32]
	mov	dword ptr [ebp - 12], eax
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	mov	byte ptr [ebp - 13], al
	cmp	byte ptr [ebp - 13], 0
	jne	LBB1_2
LBB1_1:                                 # %loop_2
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
	mov	ecx, dword ptr [ebp - 12]
	mov	edx, 24
	add	ecx, edx
	mov	ecx, dword ptr [ecx]
                                        # kill: def $cl killed $cl killed $ecx
	mov	byte ptr [eax], cl
	cmp	byte ptr [eax], 0
	je	LBB1_3
	jmp	LBB1_4
LBB1_2:                                 # %loop_after_2
	push	eax
	mov	ecx, esp
	mov	eax, ecx
	mov	dword ptr [ecx], -334606706
	push	eax
	mov	ecx, esp
	mov	dword ptr [ebp - 20], ecx       # 4-byte Spill
	mov	ecx, dword ptr [ebp - 8]
	mov	eax, dword ptr [eax]
	sub	esp, 8
	mov	dword ptr [esp], ecx
	mov	dword ptr [esp + 4], eax
	call	_find_function
	add	esp, 8
	mov	ecx, eax
	mov	eax, dword ptr [ebp - 20]       # 4-byte Reload
	mov	dword ptr [eax], ecx
	mov	eax, dword ptr [eax]
	mov	esp, ebp
	pop	ebp
	ret
LBB1_3:                                 # %loop_2.if
                                        #   in Loop: Header=BB1_1 Depth=1
	mov	al, 1
	mov	byte ptr [ebp - 13], al
	jmp	LBB1_5
LBB1_4:                                 # %loop_2.else
                                        #   in Loop: Header=BB1_1 Depth=1
	jmp	LBB1_5
LBB1_5:                                 # %loop_2.endif
                                        #   in Loop: Header=BB1_1 Depth=1
	cmp	byte ptr [ebp - 13], 0
	je	LBB1_1
	jmp	LBB1_2
                                        # -- End function
	.addrsig
	.addrsig_sym _find_function
