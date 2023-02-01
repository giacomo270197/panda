	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 1
	.intel_syntax noprefix
	.file	"example.ll"
	.def	_main;
	.scl	2;
	.type	32;
	.endef
	.globl	_main                           # -- Begin function main
	.p2align	4, 0x90
_main:                                  # @main
# %bb.0:                                # %.2
	push	ebx
	sub	esp, 8
	mov	dword ptr [esp + 4], 5
	mov	eax, 4
	mov	dword ptr [esp], eax
	mov	eax, dword ptr [esp + 4]
	#APP
	#NO_APP
	#APP
	mov	ebx, dword ptr fs:[48]
	#NO_APP
	#APP
	#NO_APP
	mov	dword ptr [esp], ebx
	mov	eax, dword ptr [esp]
	add	esp, 8
	pop	ebx
	ret
                                        # -- End function
	.addrsig
