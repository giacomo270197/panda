helper:
	push	rax
	mov	eax, edx
	mov	dword ptr [rsp + 4], ecx
	mov	dword ptr [rsp], eax
	mov	ecx, 2
	add	eax, ecx
	mov	dword ptr [rsp + 4], eax
	pop	rcx
	ret

main:                           # %.2
	sub	rsp, 56
	mov	eax, 4
	mov	ecx, eax
	mov	dword ptr [rsp + 52], ecx
	mov	eax, 3
	mov	edx, eax
	mov	dword ptr [rsp + 48], edx
	call	helper
	mov	dword ptr [rsp + 44], eax
	add	rsp, 56
	ret