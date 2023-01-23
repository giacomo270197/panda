start:
       mov ebp, esp
       sub esp, 0x624
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
       push 0x006c6c
       push 0x642e3233
       push 0x72657375
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0xbc4da2a8
       call dword ptr [ebp+0x04]
       mov [ebp+0x28], eax
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
   strcat:
       push ebp
       mov ebp, esp
       sub esp, 0x1c
       mov eax, [ebp+0x8]
       push eax
       call strlen
       mov dword ptr [ebp-0x4], eax
       mov eax, [ebp+0xc]
       push eax
       call strlen
       mov dword ptr [ebp-0x8], eax
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0x8]
       add eax, ebx
       mov dword ptr [ebp-0xc], eax
       mov eax, [ebp-0xc]
       add eax, 1
       mov dword ptr [ebp-0xc], eax
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x2
       call dword ptr [esi+0x20]
       mov dword ptr [ebp-0x10], eax
       mov eax, [ebp-0x10]
       mov ebx, [ebp-0xc]
       push ebx
       push 0x8
       push eax
       call dword ptr [esi+0x24]
       mov dword ptr [ebp-0x14], eax
       mov dword ptr [ebp-0x18], 0x0
   while_stmt3:
       mov eax, [ebp-0x18]
       mov ebx, [ebp-0x4]
       cmp eax, ebx
       jg while_stmt3_end
       mov eax, [ebp-0x14]
       mov ebx, [ebp-0x18]
       add eax, ebx
       mov ecx, [ebp+0x8]
       mov edx, [ebp-0x18]
       add ecx, edx
       mov cl, byte ptr[ecx]
       movzx ecx, cl
       mov byte ptr [eax], cl
       mov eax, [ebp-0x18]
       add eax, 1
       mov dword ptr [ebp-0x18], eax
       jmp while_stmt3
   while_stmt3_end:
       mov dword ptr [ebp-0x18], 0x0
   while_stmt4:
       mov eax, [ebp-0x18]
       mov ebx, [ebp-0x8]
       cmp eax, ebx
       jg while_stmt4_end
       mov eax, [ebp-0x18]
       mov ebx, [ebp-0x4]
       add eax, ebx
       mov dword ptr [ebp-0x1c], eax
       mov eax, [ebp-0x14]
       mov ebx, [ebp-0x1c]
       add eax, ebx
       mov ecx, [ebp+0xc]
       mov edx, [ebp-0x18]
       add ecx, edx
       mov cl, byte ptr[ecx]
       movzx ecx, cl
       mov byte ptr [eax], cl
       mov eax, [ebp-0x18]
       add eax, 1
       mov dword ptr [ebp-0x18], eax
       jmp while_stmt4
   while_stmt4_end:
       mov eax, [ebp-0x14]
       mov ebx, [ebp-0xc]
       add eax, ebx
       mov byte ptr [eax], 0x0
       mov eax, [ebp-0x14]
       mov esp, ebp
       pop ebp
       ret
   main:
       push ebp
       mov ebp, esp
       sub esp, 0xc
       push 0x00206f
       push 0x6c6c6548
       mov [ebp-0x4], esp
       push 0x002164
       push 0x6c726f77
       mov [ebp-0x8], esp
       push 0x06e6f69
       push 0x74706143
       mov [ebp-0xc], esp
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0x8]
       push ebx
       push eax
       call strcat
       mov ecx, [ebp-0xc]
       push 0x0
       push ecx
       push eax
       push 0x0
       call dword ptr [esi+0x28]
       mov eax, 1
       mov esp, ebp
       pop ebp
       ret