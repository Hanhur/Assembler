include main.inc

.code
start:

    fn Main
    ;-----------------------
    fn ExitProcess,eax
    ;***********************
Main proc

    ;mov esi,offset stack
    ;-----------------------
    ;fn CStack_Init,esi
    ;-----------------------
    ;fn RevStr,esi,offset szABC
    ;-----------------------
    ;print eax
    ;putchar 10
    ;-----------------------
    ;fn CStack_Destroy,esi
    ;-----------------------
    ;fn fRevStr,offset szABC
    ;fn fRevString,offset szABC,4
    
    ;print offset szABC
    ;putchar 10
    fld fnum1
    fld fnum2
    fdivp st(1),st
    fn floor
    ;fn ceil
    ;------------------
    printf("%u",eax)
    
    inkey
    xor eax,eax
	ret
Main endp
;***********************
floor proc
    LOCAL iResult:DWORD
    LOCAL wCw:WORD
    
    
    fstcw word ptr[wCw]
    fwait
    ;-----------------
    movzx eax,word ptr[wCw]
    ;-----------------
    and ax,0F3FFh           ;clears only the RC bits, leaving all other bits unchanged
    or    ax,0400h          ;this will set both bits of the RC field to the floor mode
    push  eax               ;use the stack to store the modified Control Word in memory
    fldcw [esp]             ;load the modified Control Word
    ;-----------------
    frndint                 ;other FPU instruction(s) needing the floor mode
    fistp dword ptr[iResult]
    ;-----------------
    fldcw word ptr[wCw]     ;restore the previous Control Word
    pop   eax               ;clean-up the stack
    ;-----------------
    mov eax,dword ptr[iResult]



	ret
floor endp
ceil proc
    LOCAL iResult:DWORD
    LOCAL wCw:WORD
    
    
    fstcw word ptr[wCw]
    fwait
    ;-----------------
    movzx eax,word ptr[wCw]
    ;-----------------
    and ax,0F3FFh           ;clears only the RC bits, leaving all other bits unchanged
    or    ax,0800h          ;this will set both bits of the RC field to the ceiling mode
    push  eax               ;use the stack to store the modified Control Word in memory
    fldcw [esp]             ;load the modified Control Word
    ;-----------------
    frndint                 ;other FPU instruction(s) needing the ceiling mode
    fistp dword ptr[iResult]
    ;-----------------
    fldcw word ptr[wCw]     ;restore the previous Control Word
    pop   eax               ;clean-up the stack
    ;-----------------
    mov eax,dword ptr[iResult]

	ret
ceil endp
iceil proc uses ebx esi edi a:DWORD,b:DWORD

    mov ebx,dword ptr[a]
    add ebx,dword ptr[b]
    lea eax,dword ptr[ebx-1]
    ;------------------
    xor edx,edx
    ;------------------
    idiv dword ptr[b]
    ;------------------

	ret
iceil endp
;****************************
fRevString proc uses ebx esi edi lpStr:DWORD,nLen:DWORD

    push lpStr
    pop esi
    ;-------------
    mov ecx,dword ptr[nLen]
    ;-------------
    or ecx,ecx
    jle @@Ret
    ;------------
    xor edx,edx
    xor eax,eax
    ;------------
    mov al,byte ptr[esi]
    mov dl,byte ptr[esi+ecx-1]
    ;------------
    mov byte ptr[esi+ecx-1],al
    mov byte ptr[esi],dl
    ;------------
    inc esi
    dec dword ptr[nLen]
    dec dword ptr[nLen]
    ;-----------
    fn fRevString,esi,nLen

    ;-----------
@@Ret:
	ret
fRevString endp
;****************************
fRevStr proc uses ebx esi edi lpStr:DWORD

    push lpStr
    pop esi
    ;-------------
    xor eax,eax
    xor ecx,ecx
    ;-------------
@@Do:
    mov al,byte ptr[esi+ecx]
    or al,al
    je @F
    ;-------------
    push eax
    inc ecx
    jmp @@Do
    
@@:
    pop eax
    mov byte ptr[esi],al
    ;--------------
    inc esi
    dec ecx
    or ecx,ecx
    jne @B
    ;--------------
    push lpStr
    pop eax

	ret
fRevStr endp



;****************************
RevStr proc uses ebx esi edi ptStack:DWORD,lpStr:DWORD

    mov esi,lpStr
    mov edi,ptStack
    xor ecx,ecx
    ;------------------------
@@Do:
    ;------------------------
    movzx eax,byte ptr[esi+ecx]
    or eax,eax
    je @@End
    ;------------------------
    push ecx
    ;------------------------
    fn CStack_Push,edi,eax
    ;------------------------
    pop ecx
    inc ecx
    jmp @@Do
@@End:
    mov ebx,dword ptr[edi+4]
    jmp @@For
@@In:
    fn CStack_Pop,edi
    ;------------------------
    mov byte ptr[esi],al
    inc esi
    dec ebx
@@For:
    or ebx,ebx
    jg @@In
    ;------------------------
    push lpStr
    pop eax
	ret
RevStr endp
end start