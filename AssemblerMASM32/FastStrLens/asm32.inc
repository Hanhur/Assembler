;==========================================================================
; Agner Fog's algorithm for finding a null byte in a zero-terminated string 
;========================================================================== 

str_len32        proto :DWORD
str_cmp32        proto :DWORD, :DWORD
str_cat32        proto :DWORD, :DWORD

mem_cpy32        proto :DWORD, :DWORD, :DWORD

.code

str_len32 proc uses ebx esi edi lpszString:DWORD

    push dword ptr[ebp + 8]
    pop ecx                            ; get pointer to string
    push ecx
    pop eax                            ; copy pointer
    and ecx, 3                         ; lower 2 bits of address, check alignment
    je @@In                            ; string is aligned by 4. Go to loop
    ;--------------------------------
    and eax, -4                        ; align pointer by 4
    push dword ptr[eax]
    pop ebx                            ; read from nearest preceding boundary
    shl ecx, 3                         ; mul by 8 = displacement in bits
    or edx, 0FFFFFFFFh                 ; mov edx -1
    shl edx, cl                        ; make byte mask
    not edx                            ; mask = 0FFH for false bytes
    or  ebx, edx                       ; mask out false bytes
    
    ;--------------------------------
    ; check first four bytes for zero
    ;--------------------------------
    
    lea ecx, dword ptr[ebx - 01010101h]; subtract 1 from each byte
    not ebx                            ; invert all bytes
    and ecx, ebx                       ; and these two
    and ecx, 80808080h                 ; test all sign bits
    jne @@Ret                          ; zero-byte found
    
    ;--------------------------------  
    ; Main loop, read 4 bytes aligned
    ;--------------------------------
    
@@For:     
    add eax, 4                         ; increment pointer by 4
@@In:    
    push dword ptr[eax] 
    pop edx                            ; read 4 bytes of string
    lea ecx, dword ptr[edx - 01010101h]; subtract 1 from each byte
    not edx                            ; invert all bytes
    and ecx, edx                       ; and these two
    and ecx, 80808080h                 ; test all sign bits
    je  @@For                          ; no zero bytes, continue loop
        
@@Ret: 
    ;---------------------------------
    ; Find position of null byte
    ;---------------------------------
        
    bsf ecx, ecx                        ; find right-most 1-bit
    shr ecx, 3                          ; divide by 8 = byte index
    sub eax, dword ptr[ebp + 8]         ; subtract start address
    add eax, ecx                        ; add index to byte
    
    ret 
str_len32 endp
;=====================================================
str_cmp32 proc uses ebx esi edi str1:DWORD, str2:DWORD
    
    push str2
    push str1
    pop esi
    pop edi   
         
@@While:
    mov al, byte ptr[esi]
    cmp al, byte ptr[edi]
    jne @@Done
    ;-------------------
    test al, al
    je @F
    ;-------------------
    inc esi
    inc edi
    jmp @@While        
        
@@: 
    ;----------------------
    ; strings are equal
    ;----------------------
    
    xor eax, eax               
    jmp @@Ret
@@Done: 
      
     ;----------------------                      
     ; strings are not equal
     ;----------------------
     
     movzx eax, byte ptr[esi]        ; compare first differing byte
     movzx edx, byte ptr[edi]
	 sub eax, edx
@@Ret:
	ret 
str_cmp32 endp
;========================================================
str_cat32 proc uses ebx esi edi dest:DWORD, add_str:DWORD

    push add_str
    push dest
    pop edi
    pop esi
    ;------------
    push edi
    ;------------
    call str_len32
    ;------------
    add edi,eax
    ;------------
    push esi
    ;------------
    call str_len32
    ;------------
    inc eax
    push eax
    push edi
    push esi
    ;------------
    call mem_cpy32
    ;------------
    push dest
    pop eax

	ret
str_cat32 endp
;=================================================================
mem_cpy32 proc uses ebx esi edi src:DWORD, dest:DWORD, count:DWORD

    push count
    push dest
    push src
    ;------------
    pop esi
    pop edi
    pop ecx
    ;------------
    cld
    cmp ecx, 8
    jb @@Done
    ;------------
    test edi, 1
    je @F
    ;------------
    movsb
    dec ecx
@@:
    test edi, 2
    je @F
    ;------------
    movsw
    sub ecx, 2 
@@:
    mov edx, ecx
    shr ecx, 2
    rep movsd
    mov ecx, edx
    and ecx, 3
    rep movsb
    jmp @@Ret
@@Done:
    rep movsb
@@Ret:
	ret
mem_cpy32 endp
;===========================================================================