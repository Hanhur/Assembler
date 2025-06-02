SRC_BYTE     = 2
SRC_DWORD    = 4

;=====================================================
array_get_value      proto :DWORD,:DWORD,:DWORD,:DWORD
print_array          proto :DWORD,:DWORD

.code
;=====================================================
array_get_value proc uses ebx esi edi array:DWORD,count:DWORD,index:DWORD,uId:DWORD

    mov eax,index
    mov edx,count
    mov esi,array
    
    ;------------------------
    ;if (i < 0 || i >= count)
    ;------------------------
    
    or eax, eax
    jl @@Error
    ;------------
    cmp eax,edx
    jge @@Error
    ;------------
    test uId,SRC_BYTE
    ;------------
    jne @F
    ;------------
    test uId,SRC_DWORD
    ;------------
    je @@Error
    ;------------
    mov eax,dword ptr[esi+eax*4]
    jmp @@Ret
@@:
    movzx eax,byte ptr[esi+eax]
    jmp @@Ret
    
@@Error:
    or eax,0FFFFFFFFh
    
@@Ret:
	ret
array_get_value endp
;==================================================
print_array proc uses ebx esi edi array:DWORD,count:DWORD

    mov esi,array
    mov edi,count
    xor ebx,ebx
    
@@For:
    mov eax,dword ptr[esi+ebx*4]
    ;-----------
    printf("%i, ",eax)
    ;printf("%i, ", dword ptr[esi + ebx * 4])
    ;-----------
    inc ebx
    lea eax,dword ptr[ebx+1]
    cmp eax,edi
    jl @@For ; esli menshe
    ;-----------
    mov eax,dword ptr[esi+ebx*4]
    ;-----------
    printf("%i\n",eax)
    ;-----------

	 ret
print_array endp
;==================================================
swap proc uses ebx esi edi val1_ptr:DWORD,val2_ptr:DWORD

    mov esi,val1_ptr
    mov edi,val2_ptr
    ;----------
    mov eax,dword ptr[esi]
    mov edx,dword ptr[edi]
    ;----------
    mov dword ptr[esi],edx
    mov dword ptr[edi],eax
    ;----------
  
	ret
swap endp
;==================================================
bubble_sort proc uses ebx esi edi arr:DWORD,count:DWORD
    
    push ebp
    mov esi,arr
    mov edi,count
    dec edi
    xor ebx,ebx
    jmp @@For
@@In:
    xor ebp,ebp
    xor edx,edx
    
@@For2:
    mov eax,dword ptr[esi+edx*4]
    mov ecx,dword ptr[esi+edx*4+4]
    cmp eax,ecx
    jle @@Next
    ;-----------
    mov dword ptr[esi+edx*4],ecx
    mov dword ptr[esi+edx*4+4],eax
    mov ebp,1
    ;----------
@@Next:
    inc edx
    mov eax,edi
    sub eax,ebx
    cmp edx,eax
    jl @@For2
    ;----------
    test ebp,0FFFFFFFFh
    je @@Ret
    ;----------
    inc ebx
@@For:
    cmp ebx,edi
    jl @@In
    ;-----------
@@Ret:
    pop ebp
    mov eax,esi
    
	ret
bubble_sort endp