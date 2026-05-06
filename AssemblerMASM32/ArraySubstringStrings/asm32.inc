;==========================================================================
; Agner Fog's algorithm for finding a null byte in a zero-terminated string 


;========================================================================== 

strlen32         proto :DWORD
strcmp32         proto :DWORD,:DWORD
stricmp32        proto :DWORD,:DWORD
strcat32         proto :DWORD,:DWORD
substr32         proto :DWORD,:DWORD,:DWORD,:DWORD
str_to_lower32   proto :DWORD
str_to_upper32   proto :DWORD
strstr32         proto :DWORD,:DWORD
strcpy32         proto :DWORD,:DWORD
strcount_UTF832  proto :DWORD
strcount_in_set  proto :DWORD,:DWORD

mem_cpy32        proto :DWORD,:DWORD,:DWORD

.code

strlen32 proc uses ebx esi edi lpszString:DWORD

    push dword ptr[ebp+8]
    pop ecx                            ; get pointer to string
    push ecx
    pop eax                            ; copy pointer
    and ecx,3                          ; lower 2 bits of address, check alignment
    je @@In                            ; string is aligned by 4. Go to loop
    ;--------------------------------
    and eax, -4                        ; align pointer by 4
    push dword ptr[eax]
    pop ebx                            ; read from nearest preceding boundary
    shl ecx,3                          ; mul by 8 = displacement in bits
    or edx,0FFFFFFFFh                  ; mov edx -1
    shl edx,cl                         ; make byte mask
    not edx                            ; mask = 0FFH for false bytes
    or  ebx,edx                        ; mask out false bytes
    
    ;--------------------------------
    ; check first four bytes for zero
    ;--------------------------------
    
    lea ecx,dword ptr[ebx-01010101h]   ; subtract 1 from each byte
    not ebx                            ; invert all bytes
    and ecx,ebx                        ; and these two
    and ecx,80808080h                  ; test all sign bits
    jne @@Ret                          ; zero-byte found
    
    ;--------------------------------  
    ; Main loop, read 4 bytes aligned
    ;--------------------------------
    
@@For:     
    add eax,4                          ; increment pointer by 4
@@In:    
    push dword ptr[eax] 
    pop edx                            ; read 4 bytes of string
    lea ecx,dword ptr[edx-01010101h]   ; subtract 1 from each byte
    not edx                            ; invert all bytes
    and ecx,edx                        ; and these two
    and ecx,80808080h                  ; test all sign bits
    je  @@For                          ; no zero bytes, continue loop
        
@@Ret: 
    ;---------------------------------
    ; Find position of null byte
    ;---------------------------------
        
    bsf ecx,ecx                        ; find right-most 1-bit
    shr ecx,3                          ; divide by 8 = byte index
    sub eax,dword ptr[ebp+8]           ; subtract start address
    add eax,ecx                        ; add index to byte
    
    ret 
strlen32 endp
;===========================================================================
strcmp32 proc uses ebx esi edi str1:DWORD,str2:DWORD
    
    push str2
    push str1
    pop esi
    pop edi   
         
@@While:
    mov al,byte ptr[esi]
    cmp al,byte ptr[edi]
    jne @@Done
    ;-------------------
    test al,al
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
     
     movzx eax,byte ptr[esi]        ; compare first differing byte
     movzx edx,byte ptr[edi]
	 sub eax,edx
@@Ret:
	ret 
strcmp32 endp
;===========================================================================
strcat32 proc uses ebx esi edi dest:DWORD,add_str:DWORD

    push add_str
    push dest
    pop edi
    pop esi
    ;------------
    push edi
    ;------------
    call strlen32
    ;------------
    add edi,eax
    ;------------
    push esi
    ;------------
    call strlen32
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
strcat32 endp
;===========================================================================
mem_cpy32 proc uses ebx esi edi src:DWORD,dest:DWORD,count:DWORD

    push count
    push dest
    push src
    ;------------
    pop esi
    pop edi
    pop ecx
    ;------------
    cld
    cmp ecx,8
    jb @@Done
    ;------------
    test edi,1
    je @F
    ;------------
    movsb
    dec ecx
@@:
    test edi,2
    je @F
    ;------------
    movsw
    sub ecx,2 
@@:
    mov edx,ecx
    shr ecx,2
    rep movsd
    mov ecx,edx
    and ecx,3
    rep movsb
    jmp @@Ret
@@Done:
    rep movsb
@@Ret:
	ret
mem_cpy32 endp
;===========================================================================
substr32 proc uses ebx esi edi dest:DWORD,src:DWORD,pos:DWORD,dwlen:DWORD

    push src
    ;----------------
    call strlen32           ; eax = str_len32(source)
    ;----------------
    push pos
    pop edx                  ; pos
    sub eax,edx              ; max length = str_len32(source) - pos
    ;----------------
    jbe @F                   ; str_len32(source) <= pos. Return empty string
    ;----------------
    push dwlen
    pop ecx        
    cmp eax,ecx
    cmova eax,ecx             ; min(len, maxlen)
    ;----------------
    add edx,src               ; source + pos
    ;----------------
    push eax
    push eax                  ; length for mem_cpy
    push dest
    push edx                 
    ;----------------        
    call mem_cpy32
    ;----------------
    pop eax                   ; return final length
    push dest
    pop ecx
    and byte ptr[ecx+eax],0   ; terminating zero        
    ;-------------------
    jmp @@Ret 
@@:  
    ;--------------------
    ; return empty string
    ;--------------------
   
    xor eax,eax
    push dest
    pop ecx
    mov byte ptr[ecx],al
    ;--------------------
    ;return 0
    ;--------------------
@@Ret:
	ret
substr32 endp
;===========================================================================
str_to_lower32 proc uses ebx esi edi lpszString:DWORD

     push lpszString
     pop esi
@@For:
     mov al,byte ptr[esi]
     or al,al
     je @@Ret                 ; end of string
     ;-------------------
	 sub al, 'A'
	 cmp al, 'Z' - 'A'
	 jbe @F                   ; is upper case
	 ;-------------------
@@Next:
	 inc esi
	 jmp @@For                ; loop to next character
@@:   
                              ; convert to lower case
     add al, 'a'
	 mov byte ptr[esi],al
	 jmp @@Next
@@Ret:
     push lpszString
     pop eax
     ret
str_to_lower32 endp
;===========================================================================
str_to_upper32 proc uses ebx esi edi lpszString:DWORD

     push lpszString
     pop esi
@@For:
     mov al,byte ptr[esi]
     or al,al
     je @@Ret                    ; end of string
     ;-------------------
	 sub al, 'a'
	 cmp al, 'z' - 'a'
	 jbe @F                      ; is lower case
	 ;-------------------
@@Next:
	 inc esi
	 jmp @@For                   ; loop to next character
@@::                             ; convert to upper case
     add al, 'A'
     mov byte ptr[esi],al
	 jmp @@Next
@@Ret:
     push lpszString
     pop eax
     ret
str_to_upper32 endp
;=================================================================================
; Searches for substring needle in string haystack. Return value is pointer to 
; first occurrence of needle, or NULL if not found. The strings must be zero-terminated.
;=================================================================================
strstr32 proc uses ebx esi edi haystack:DWORD,needle:DWORD

    push needle
    push haystack
    pop esi
    pop edi
    ;------------
	mov ax,word ptr[edi]
	or al,al
	je @@Found                 ; a zero-length needle is always found
	;------------
    or ah,ah
	je @@SingleCharNeedle		
	
@@SearchLoop: 
    ;---------------------------------
    ; search for first character match
    ;---------------------------------
    
    mov cl,byte ptr[esi]
    or cl,cl
    je @@NotFound              ; end of haystack reached without finding
    ;------------------
    cmp al,cl
    je @@FirstCharMatch        ; first character match
    ;------------------
@@IncompleteMatch:
    inc esi
    jmp @@SearchLoop            ; loop through haystack
	
@@FirstCharMatch:
    mov ecx, esi               ; begin of match position
@@MatchLoop:
    inc ecx
    inc edi
    mov al,byte ptr[edi]
    or al,al
    je @@Found                 ; end of needle. match ok
    ;------------------
    cmp al,byte ptr[ecx] 
    je @@MatchLoop
    
    ;-----------------------------------
    ; match failed, recover and continue
    ;-----------------------------------
    
    push needle
	pop edi
	mov al,byte ptr[edi]
	jmp @@IncompleteMatch
	
@@NotFound:
    ;--------------------------- 
    ; needle not found. return 0
    ;---------------------------
    xor eax, eax
    jmp @@Ret
    
@@Found: 
    ;-----------------------------------------------------
    ; needle found. return pointer to position in haystack
    ;-----------------------------------------------------
    
    push esi
    pop eax
@@Ret:
    ret		

@@SingleCharNeedle: 
    ;-----------------------------
    ; Needle is a single character
    ;-----------------------------
    
    movzx ecx,byte ptr[esi]
    or cl,cl
    je @@NotFound              ; end of haystack reached without finding
    cmp al,cl
    je @@Found
    inc esi
    jmp @@SingleCharNeedle     ; loop through haystack
strstr32 endp
;===========================================================================
; Faster version of the standard stricmp or strcasecmp function:

; Compares two zero-terminated strings without case sensitivity.
; Does not recognize locale-specific characters. A-Z are changed
; to a-z before comparing, while other upper-case letters are not
; converted but considered unique.
;===========================================================================
stricmp32 proc uses ebx esi edi string1:DWORD,string2:DWORD

    push string2
    push string1
    pop ecx
    pop edx
    sub edx,ecx
        
@@L1:    
    mov al,byte ptr[ecx]
    cmp al,byte ptr[ecx+edx]
    ;--------------
    jne @@L2
    ;--------------
    inc ecx
    or al,al
    jne @@L1                   ; continue with next byte
    
    ;-----------------------------------------
    ;terminating zero found. Strings are equal
    ;-----------------------------------------
    
    xor eax,eax
    jmp @@Ret       
        
@@L2:    
    ;--------------------------------
    ; bytes are different. check case
    ;--------------------------------
    
    xor al,20h                  ; toggle case
    cmp al,byte ptr[ecx+edx]
    jne @@L3
    
    ;----------------------------------------------
    ; possibly differing only by case. Check if a-z
    ;----------------------------------------------
    
    or al,20h                   ; upper case
    sub al, 'a'
    cmp al, 'z'-'a'
    ja @@L3                     ; not a-z
    
    ;-------------------------------
    ; a-z and differing only by case
    ;-------------------------------
    
    inc ecx
    jmp @@L1                    ; continue with next byte

@@L3:    
    ;----------------------------------------------
    ; bytes are different, even after changing case
    ;----------------------------------------------
    
    movzx eax,byte ptr[ecx]      ; get original value again
    sub eax,'A'
    cmp eax,'Z' - 'A'
    ja @@L4
    ;----------------
    add eax,20h
@@L4:    
    movzx edx,byte ptr[ecx+edx]
    sub edx,'A'
    cmp edx,'Z' - 'A'
    ja @F
    ;----------------
    add edx,20h
@@:    
    sub     eax, edx                 ; subtract to get result
@@Ret:   
	ret
stricmp32 endp
;===========================================================================
; Faster version of the standard strcpy function:
; char * strcpy32(char * dest, const char * src);
; Copies zero-terminated string from src to dest, including terminating zero.
;===========================================================================
strcpy32 proc uses ebx esi edi dest:DWORD,src:DWORD
    
    
    push dest
    push src
    pop esi
    pop edi
    ;------------
    push esi
    ;------------
    call strlen32              ; length of src
    ;------------
    inc eax                    ; include terminating zero in length
    ;------------
    push    eax                ; length+1
    push edi                   ; dest
    push esi                   ; src
    ;------------
    call mem_cpy32              ; copy
    ;------------
    push dest
    pop eax
	ret
strcpy32 endp
;===========================================================================
; Counts the number of characters in a UTF-8 encoded string.
;
; This functions does not check if the string contains valid UTF-8 code, it 
; simply counts all bytes except continuation bytes 10xxxxxxB.
;===========================================================================
strcount_UTF832 proc uses ebx esi edi str_src:DWORD
 
    push str_src
    pop esi
    ;------------
    xor eax,eax                ; character counter
    xor ecx,ecx                ; zero extend cl
@@:
    mov cl,byte ptr[esi]       ; one byte fron string
    or cl,cl
    je @@Ret                   ; terminating zero
    ;-------------
    sub cl, 10000000b          ; lower limit of continuation bytes
    cmp cl, 00111111b          ; upper limit - lower limit
    seta cl                    ; 1 if outside limit (unsigned compare includes negative values as above)
    add eax,ecx
    inc esi
    jmp @B
        
@@Ret:
	 ret
strcount_UTF832 endp
;===========================================================================
strcount_in_set proc uses ebx esi edi str_src:DWORD,str_set:DWORD

    push str_set
    push str_src
    pop esi
    pop edi
    ;-----------
    xor eax,eax               ; match counter
@@str_next:
    mov cl,byte ptr[esi]      ; read one byte from str
    or cl,cl
    je @@Ret                  ; str finished
@@set_next:
    mov dl,byte ptr[edi]
    or dl,dl
    je @@set_finished
    ;-----------
    inc edi                    ; next in set
    cmp cl,dl
    jne @@set_next
    
    ;------------------------------------------
    ;character match found, goto next character
    ;------------------------------------------
    
    inc eax                    ; count match

@@set_finished: 
    ;---------------------------
    ; end of set, no match found
    ;---------------------------
    
    push str_set
    pop edi                    ; restore set pointer
    inc esi
    jmp @@str_next             ; next in string

@@Ret:
    ;----------------------------
    ; end of str, count is in eax
    ;----------------------------
	ret
strcount_in_set endp
;===========================================================================