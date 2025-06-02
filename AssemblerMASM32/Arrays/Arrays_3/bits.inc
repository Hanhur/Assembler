.code
;=======================================
int_mul proc uses ebx esi edi a:DWORD,b:DWORD

    xor ebx,ebx  ;result
    
    ;-----------
    ;while b >0
    ;-----------
    
@@While:
    mov eax,b
    mov edx,eax
    mov ecx,a
    or eax,eax
    je @@Ret
    ;------------
    ;if b is Odd?
    ;------------
    and eax,1
    je @F        ; no, b is Even
    ;----------
    add ebx,ecx  ;yes, b is Odd
@@:
    ;----------
    ;a = a * 2
    ;b = b \ 2
    ;----------
    
    shl ecx,1
    shr edx,1
    mov a,ecx
    mov b,edx
    jmp @@While 

@@Ret:
    mov eax,ebx
	ret
int_mul endp
int_imul proc uses ebx esi edi a:DWORD,b:DWORD

    mov eax,b
    or eax,eax
    je @@Ret
    ;-----------
    jle @F
    
    ;----------------
    ;when b > 0
    ;add a one by one
    ;----------------

    dec eax
    ;-----------
    push eax
    push a
    ;-----------
    call int_imul
    ;-----------
    mov edx,a
    add eax,edx
    ;-----------
    jmp @@Ret
@@:
    jns @@Ret
    
    ;------------
    ;when b < 0
    ;------------
    
    neg eax
    push eax
    push a
    ;------------
    call int_imul
    ;------------
    neg eax
    
@@Ret:
	ret
int_imul endp
;===========================================
get_bit proc number:DWORD,position:DWORD
    
    mov eax,number
    mov ecx,position
    sar eax,cl
    and eax,1
    
	ret
get_bit endp
;=======================================
set_bit proc number:DWORD,position:DWORD

    mov eax,number
    mov ecx,position
    mov edx,1
    shl edx,cl
    or eax,edx
    
	ret
set_bit endp
;=======================================
clear_bit proc number:DWORD,position:DWORD

    mov eax,number
    mov ecx,position
    mov edx,1
    shl edx,cl
    not edx
    and eax,edx
    
	ret
clear_bit endp
;=======================================
toggle_bit proc number:DWORD,position:DWORD

    mov eax,number
    mov ecx,position
    mov edx,1
    shl edx,cl
    xor eax,edx
    
	ret
toggle_bit endp
;=======================================
is_sign_equal proc n1:DWORD,n2:DWORD

    mov eax,n1
    mov edx,n2
    xor eax,edx
    shr eax,1Fh
    sete al
	ret
is_sign_equal endp
;========================================
get_set_bits_count proc uses ebx esi edi number:DWORD

    ;---------------
    ;  Init result
    ;---------------
    
    xor eax,eax
    
    mov edx,number
    
    ;----------------
    ;while number > 0
    ;----------------
@@While:
    or edx,edx
    je @@Ret
    
    ;----------------
    ;Check right bit
    ;----------------
    ;1*1 = 1
    ;1*0 = 0
    ;----------------
    
    mov ecx,edx
    and ecx,1
    
    ;----------------
    ;Count
    ;----------------
    
    add eax,ecx

    ;----------------
    ;Get next bit
    ;----------------
    
    shr edx,1
    
    ;----------------
    ;Continue loop
    ;----------------
    
    jmp @@While

@@Ret:
	ret
get_set_bits_count endp
;===================================================
is_power_of_two proc uses ebx esi edi number:DWORD

    mov eax,number
    
    ;---------------
    ;n == 0 ?
    ;---------------
    
    or eax,eax
    je @@Ret
    
    ;--------------------------
    ;if n is a power of 2 
    ;then AND of n and n-1 == 0
    ;--------------------------
    
    mov edx,eax
    dec edx
    and eax,edx
    sete al

@@Ret:
	ret
is_power_of_two endp
;===================================================
find_position_of_set_bit proc uses ebx esi edi number:DWORD

    mov ebx,number
    
    ;---------------------
    ;if n not power of two 
    ;return error
    ;---------------------
    
    push ebx
    ;--------------
    call is_power_of_two
    ;--------------
    or al,al
    jne @F
    ;--------------
    or eax,0FFFFFFFFh
    jmp @@Ret
    
@@:
    ;---------------------
    ;EAX --> bit position 1
    ;EDX --> 1 to check
    ;EBX --> n
    ;---------------------
    
    mov edx,1
    
    ;-------------------------------
    ;iterate through bits of n 
    ;till we find a set bit 
    ;position AND n != 0 
    ;only when position and n 
    ;have a set bit at same position 
    ;-------------------------------
    
@@While:
    ;--------------------
    ;   position AND n
    ;--------------------
    
    mov ecx,edx
    and ecx,ebx
    jne @@Ret
    
    ;---------------------
    ;Unset current bit and 
    ;set the next bit
    ;---------------------
    
    shl edx,1
    
    ;---------------------
    ;increment position
    ;---------------------
    
    inc eax
    
    jmp @@While

@@Ret:
	ret
find_position_of_set_bit endp
;===================================================
int_min proc uses ebx esi edi a:DWORD,b:DWORD

     ;-----------
     ;a xor b
     ;-----------
     
     mov eax,a
     mov edx,b
     xor edx,eax
     
     ;-----------
     ;-(if a < b)
     ;-----------
     
     cmp eax,b
     setl al
     movzx eax,al
     neg eax
     
     ;-------------------------
     ;(a xor b) and -(if a < b)
     ;-------------------------
     
     and eax,edx

     ;-----------
     ;result xor b
     ;-----------
     
     mov edx,b
     xor eax,edx

	ret
int_min endp
;===================================================
int_max proc uses ebx esi edi a:DWORD,b:DWORD

     ;-----------
     ;a xor b
     ;-----------
     
     mov eax,a
     mov edx,b
     xor edx,eax
     
     ;-----------
     ;-(if a < b)
     ;-----------
     
     cmp eax,b
     setl al
     movzx eax,al
     neg eax
     
     ;-------------------------
     ;(a xor b) and -(if a < b)
     ;-------------------------
     
     and eax,edx

     ;-----------
     ;result xor a
     ;-----------
     
     mov edx,a
     xor eax,edx

	ret
int_max endp
;===================================================
int_mins proc uses ebx esi edi a:DWORD,b:DWORD

     ;-----------
     ;a - b
     ;-----------
     
     mov eax,a
     mov edx,b
     sub eax,edx
     
     ;--------------
     ;(a - b) shr 31
     ;--------------
     
     mov edx,eax
     sar edx,1Fh
     
     ;--------------
     ;and results
     ;--------------
     
     and edx,eax
     
     ;--------------
     ;b add result
     ;--------------
     mov eax,b
     add eax,edx

	ret
int_mins endp
;===================================================
int_maxs proc uses ebx esi edi a:DWORD,b:DWORD

     ;-----------
     ;a - b
     ;-----------
     
     mov eax,a
     mov edx,b
     sub eax,edx
     
     ;--------------
     ;(a - b) shr 31
     ;--------------
     
     mov edx,eax
     sar edx,1Fh
     
     ;--------------
     ;and results
     ;--------------
     
     and edx,eax
     
     ;--------------
     ;a sub result
     ;--------------
     mov eax,a
     sub eax,edx

	ret
int_maxs endp
;===================================================
;===================================================