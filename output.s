	.text
	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
.set @feat.00, 1
	.intel_syntax noprefix
	.file	"example.ll"
	.def	_add;
	.scl	2;
	.type	32;
	.endef
	.globl	_add                            # -- Begin function add
	.p2align	4, 0x90
_add:                                   # @add
# %bb.0:                                # %.4
	push	eax
	mov	ecx, dword ptr [esp + 12]
	mov	eax, dword ptr [esp + 8]
	add	eax, ecx
	mov	dword ptr [esp], eax
	mov	eax, esp
	pop	ecx
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
	and	esp, -8
	sub	esp, 24
	mov	ecx, 5
	mov	dword ptr [esp + 20], 5
	mov	eax, 6
	mov	dword ptr [esp + 16], eax
	mov	dword ptr [esp], ecx
	mov	dword ptr [esp + 4], eax
	call	_add
	mov	dword ptr [esp + 8], eax
	mov	eax, dword ptr [eax]
	mov	esp, ebp
	pop	ebp
	ret
                                        # -- End function
	.addrsig
	.addrsig_sym _add
