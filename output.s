helper:
	push	rax
	mov	eax, ecx
	mov	dword ptr [rsp + 4], eax
	mov	dword ptr [rsp], edx
	mov	ecx, 2
	add	edx, ecx
	mov	dword ptr [rsp + 4], edx
	pop	rcx
	ret

main:
	sub	rsp, 24
	mov	dword ptr [rsp + 20], 0
	mov	dword ptr [rsp + 16], 0
	mov	dword ptr [rsp + 12], 0
	mov	dword ptr [rsp + 8], 0
	mov	dword ptr [rsp + 8], 1
	mov	dword ptr [rsp + 12], 2
	mov	dword ptr [rsp + 16], 3
	mov	dword ptr [rsp + 20], 4
	mov	eax, dword ptr [rsp + 16]
	mov	dword ptr [rsp + 4], eax
	mov	ecx, 3
	add	eax, ecx
	mov	dword ptr [rsp + 20], eax
	mov	eax, dword ptr [rsp + 20]
	add	rsp, 24
	ret