include asm32.inc

solution proto :DWORD

.code
;==================================================
;Returns a pointer to an array of string pointers.
;The last element of the array is NULL
;==================================================
solution proc uses ebx esi edi src_str:DWORD
    LOCAL vector:DWORD
    LOCAL lens:DWORD
    LOCAL i:DWORD

    push src_str
    pop esi
    push esi
    ;-----------------
    call strlen32
    ;-----------------
    push eax
    pop lens
    ;-----------------
    and eax, 1
    or eax, eax
    jne @@Odd
    
    ;--------------------
    ;Even number of chars
    ;--------------------
    
    push lens
    pop eax
    shr eax, 1
    inc eax
    shl eax, 2
    ;--------------------
    fn GlobalAlloc, GPTR, eax
    ;--------------------
    push eax
    pop vector
    ;--------------------
    and i, 0
    xor ebx, ebx
    jmp @@For
@@In:
    fn GlobalAlloc, GPTR, 4
    ;--------------------
    push eax
    pop edi
    ;--------------------
    movzx eax, word ptr[esi + ebx]
    mov word ptr[edi], ax
    ;--------------------
    mov edx, vector
    mov eax, i
    mov dword ptr[edx + eax * 4], edi
    add i, 1
    ;-------------------
    add ebx, 2
@@For:
    mov eax, lens
    sub eax, 1
    cmp ebx, eax
    jl @@In
    ;-------------------
    jmp @@Ret
@@Odd:
    ;-------------------
    ;Odd number of chars
    ;-------------------
    
    push lens
    pop eax
    inc eax
    shr eax, 1
    inc eax
    shl eax, 2
    ;--------------------
    fn GlobalAlloc, GPTR, eax
    ;--------------------
    push eax
    pop vector
    ;--------------------
    and i, 0
    xor ebx, ebx
    jmp @@For2
@@In2:
    fn GlobalAlloc, GPTR, 4
    ;--------------------
    push eax
    pop edi
    ;--------------------
    movzx eax, word ptr[esi + ebx]
    or ah, ah
    jne @F
    ;--------------------
    mov ah, '_'
@@:
    mov word ptr[edi], ax
    ;--------------------
    mov edx, vector
    mov eax, i
    mov dword ptr[edx + eax * 4], edi
    add i, 1
    ;-------------------
    add ebx, 2
@@For2:
    mov eax, lens
    cmp ebx, eax
    jl @@In2
    
@@Ret:
    push vector
    pop eax
	ret
solution endp