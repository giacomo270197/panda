start:
       jmp main
   main:
       push ebp
       mov ebp, esp
       sub esp, 0x8
       mov dword ptr [ebp-0x4], 0x1
       mov dword ptr [ebp-0x8], 0x2
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0x8]
       xor eax, ebx
       mov dword ptr [ebp-0x4], eax
       ;  This is a comment
       mov eax, 1
       mov esp, ebp
       pop ebp
       ret