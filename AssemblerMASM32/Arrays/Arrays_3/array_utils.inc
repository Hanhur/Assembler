SRC_BYTE    = 2
SRC_DWORD   = 4

.code
;======================================================
; Algorithm O(N)
;======================================================
get_sum proc uses ebx esi edi array:DWORD,count:DWORD

    mov esi,array
    xor ebx,ebx
    xor eax,eax
    mov ecx,count
    
@@For:

    mov edx,dword ptr[esi+ebx*4]
    add eax,edx
    ;-----------
    inc ebx
    cmp ebx,ecx
    jl @@For
    
	ret
get_sum endp
;======================================================
; Algorithm O(N)
;======================================================
find_max_value proc uses ebx esi edi array:DWORD,count:DWORD

    mov esi,array
    mov edi,count
    
    ;------------------
    ;assuming max value
    ;------------------
    
    mov eax,dword ptr[esi]
    ;--------------
    xor ebx,ebx
   
@@For:
    
    inc ebx
    cmp ebx,edi
    jge @@Ret
    ;-------------
    mov edx,dword ptr[esi+ebx*4]
    cmp edx,eax
    jle @@For
    ;-------------
    mov eax,edx
    ;-------------
    jmp @@For
    
@@Ret:
	ret
find_max_value endp
;======================================================
; Algorithm O(N)
;======================================================
find_min_value proc uses ebx esi edi array:DWORD,count:DWORD

    mov esi,array
    mov edi,count
    
    ;------------------
    ;assuming min value
    ;------------------
    
    mov eax,dword ptr[esi]
    ;--------------
    xor ebx,ebx
   
@@For:
    
    inc ebx
    cmp ebx,edi
    jge @@Ret
    ;-------------
    mov edx,dword ptr[esi+ebx*4]
    cmp edx,eax
    jge @@For
    ;-------------
    mov eax,edx
    ;-------------
    jmp @@For
    
@@Ret:
	ret
find_min_value endp
;======================================================
; Algorithm O(N)
;======================================================
find_max_value_ex proc uses ebx esi edi begin_addr:DWORD,end_addr:DWORD

    mov esi,begin_addr
    mov edi,end_addr
    
    ;------------------
    ;assuming max value
    ;------------------
    
    mov eax,dword ptr[esi]
    
@@For:
    
    lea esi,dword ptr[esi+4]
    cmp esi,edi
    je @@Ret
    ;-------------
    mov edx,dword ptr[esi]
    cmp edx,eax
    jle @@For
    ;-------------
    mov eax,edx
    ;-------------
    jmp @@For
    
@@Ret:
	ret
find_max_value_ex endp
;======================================================
; Algorithm O(N)
;======================================================
find_min_value_ex proc uses ebx esi edi begin_addr:DWORD,end_addr:DWORD

    mov esi,begin_addr
    mov edi,end_addr
    
    ;------------------
    ;assuming min value
    ;------------------
    
    mov eax,dword ptr[esi]
    
@@For:
    
    lea esi,dword ptr[esi+4]
    cmp esi,edi
    je @@Ret
    ;-------------
    mov edx,dword ptr[esi]
    cmp edx,eax
    jge @@For
    ;-------------
    mov eax,edx
    ;-------------
    jmp @@For
    
@@Ret:
	ret
find_min_value_ex endp
;======================================================
get_value proc uses ebx esi edi array:DWORD,array_size:DWORD,index:DWORD,uId:DWORD

    mov esi,array
    mov eax,index
    mov edx,array_size
    
    ;---------------------------------
    ;if (index < 0 || index >= size )
    ;---------------------------------
    
    or eax,eax
    jl @@Error
    ;-------------
    cmp eax,edx
    jge @@Error
    ;--------------
    test uId,SRC_BYTE
    jne @F
    ;-------------
    test uId,SRC_DWORD
    je @@Error
    ;-------------
    mov eax,dword ptr[esi+eax*4]
    jmp @@Ret
    ;-------------
@@:
    movzx eax,byte ptr[esi+eax]
@@Ret:
	ret
@@Error:
    or eax,0FFFFFFFFh
    jmp @@Ret
   
get_value endp
;======================================================
get_value2 proc uses ebx esi edi array:DWORD,array_size:DWORD,index:DWORD,uId:DWORD

    mov esi,array
    mov eax,index
    mov edx,array_size
    
    ;---------------------------------
    ;if (index >= 0 && index < size )
    ;---------------------------------
    
    or eax,eax
    jge @F
    ;------------
    jmp @@Error
    ;------------
@@:
    cmp eax,edx
    jge @@Error
    ;------------
    test uId,SRC_BYTE
    jne @F
    ;-------------
    test uId,SRC_DWORD
    je @@Error
    ;-------------
    mov eax,dword ptr[esi+eax*4]
    jmp @@Ret
    ;-------------
@@:
    movzx eax,byte ptr[esi+eax]
    jmp @@Ret
    
@@Error:
    or eax,0FFFFFFFFh
    
@@Ret:
    
	ret
get_value2 endp
;======================================================
print_array proc uses ebx esi edi array:DWORD,count:DWORD

    fn set_console_color,14,0
    ;--------------
    mov esi,array
    xor ebx,ebx
@@For:
    mov eax,dword ptr[esi+ebx*4]
    ;-------------
    printf("%i, ",eax)
    ;-------------
    inc ebx
    lea eax,dword ptr[ebx+1]
    cmp eax,count
    jl @@For
    ;-------------
    mov eax,dword ptr[esi+ebx*4]
    ;-------------
    printf("%i\n",eax)
    ;-------------
    
	ret
print_array endp
;======================================================