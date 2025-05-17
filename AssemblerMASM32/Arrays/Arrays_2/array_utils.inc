SRC_BYTE  = 2
SRC_DWORD = 4

;=====================================================
;array_get_value      proto :DWORD,:DWORD,:DWORD,:DWORD
;array_get_value_bad  proto :DWORD,:DWORD,:DWORD,:DWORD

.code
;==================================================
array_get_value proc uses ebx esi edi array:DWORD,count:DWORD,index:DWORD,uId:DWORD

    mov eax,index
    mov edx,count
    mov esi,array
    
    ;------------------------
    ;if (i < 0 || i >= count)
    ;------------------------
    
    or eax, eax
    jl @@Error ;esli menshe, soznakovym znachenijem
    ;------------
    cmp eax,edx
    jge @@Error ;esli bolshe ili ravno, soznakovym znachenijem
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
array_get_value_bad proc uses ebx esi edi array:DWORD,count:DWORD,index:DWORD,uId:DWORD

    mov eax,index
    mov edx,count
    mov esi,array
    ;--------------
    .if eax < 0 || eax >= edx
    
        jmp @@Error
        
    .else
    
        .if uId == SRC_BYTE
        
            movzx eax,byte ptr[esi+eax]
            
        .elseif uId == SRC_DWORD
        
            mov eax,dword ptr[esi+eax*4]
            
        .else
        
@@Error:
            or eax,0FFFFFFFFh
            
        .endif
    
    .endif

	ret
array_get_value_bad endp
;==================================================