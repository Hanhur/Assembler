CStack_Init      proto :DWORD
CStack_Destroy   proto :DWORD
CStack_Size      proto :DWORD
CStack_IsEmpty   proto :DWORD
CStack_Push      proto :DWORD,:DWORD
CStack_Pop       proto :DWORD
;------------------------------------------
MemSet           proto :DWORD,:DWORD,:DWORD

STACK struct

      pStack     dd ?
      dwItems    dd ?

STACK ends
;******************************************
.code
CStack_Init proc uses ebx esi edi ptStack:DWORD

    push ptStack
    pop esi
    ;-------------
    and dword ptr[esi],0
    and dword ptr[esi+4],0
    ;-------------
	ret
CStack_Init endp
;********************************************
CStack_Destroy proc uses ebx esi edi ptStack:DWORD

    push ptStack
    pop esi
    ;-------------
    fn LocalFree,dword ptr[esi]
    ;-------------

	ret
CStack_Destroy endp
;*********************************************
CStack_Size proc uses ebx esi edi ptStack:DWORD

    push ptStack
    pop esi
    ;-------------
    mov eax,dword ptr[esi+4]
    shl eax,2
    ;-------------
    
	ret
CStack_Size endp
;*********************************************
CStack_IsEmpty proc uses ebx esi edi ptStack:DWORD

    push ptStack
    pop esi
    ;-------------
    mov eax,dword ptr[esi]
    or eax,eax
    je @F
    ;-----------
    xor eax,eax
    jmp @@Ret
    ;-----------
@@:
    inc eax
@@Ret:
	ret
CStack_IsEmpty endp
;**********************************************
CStack_Push proc uses ebx esi edi ptStack:DWORD,item:DWORD
    LOCAL pTemp:DWORD

    push ptStack
    pop esi
    ;-------------
    .if dword ptr[esi] == 0
    
         fn LocalAlloc,LPTR,4
         mov dword ptr[esi],eax

    .else
    
         mov eax,dword ptr[esi+4]
         push eax
         ;-----------
         inc eax
         shl eax,2
         ;-----------
         fn LocalAlloc,LPTR,eax
         ;-----------
         mov dword ptr[pTemp],eax
         ;----------
         mov ebx,eax
         ;----------
         add ebx,4
         ;----------
         pop eax
         ;----------
         fn MemSet,ebx,dword ptr[esi],eax
         ;----------
         fn LocalFree,dword ptr[esi]
         ;----------
         mov eax,dword ptr[pTemp]
         mov dword ptr[esi],eax

    .endif
   ;----------------
   push dword ptr[item]
   pop eax
   ;----------------
   mov ebx,dword ptr[esi]
   mov dword ptr[ebx],eax
   ;----------------
   inc dword ptr[esi+4]
   ;----------------
	ret
CStack_Push endp
;******************************************
CStack_Pop proc uses ebx esi edi ptStack:DWORD
    LOCAL item:DWORD
    LOCAL pTemp:DWORD

    push ptStack
    pop esi
    ;-------------
    .if dword ptr[esi] != 0

        mov ebx,dword ptr[esi]
        mov eax,dword ptr[ebx]
        mov dword ptr[item],eax
        ;----------------------
        mov eax,dword ptr[esi+4]
        dec eax
        ;----------------------
        .if eax != 0
            
            push eax
            ;------------------
            shl eax,2
            ;------------------
            fn LocalAlloc,LPTR,eax
            ;------------------
            mov dword ptr[pTemp],eax
            ;------------------
            pop eax
            ;------------------
            add ebx,4
            ;------------------
            fn MemSet,pTemp,ebx,eax
            ;------------------
            fn LocalFree,dword ptr[esi]
            ;------------------
            mov eax,dword ptr[pTemp]
            mov dword ptr[esi],eax
            
        .else
        
            fn LocalFree,dword ptr[esi]
            and dword ptr[esi],0

        .endif
    .endif
    
    dec dword ptr[esi+4]
    mov eax,dword ptr[item]

	ret
CStack_Pop endp
;******************************************
MemSet proc uses ebx esi edi pDest:DWORD,pSrc:DWORD,dwSize:DWORD

   mov edi,pDest
   mov esi,pSrc
   mov ecx,dword ptr[dwSize]
   ;--------------
@@Do:
   lodsd
   stosd
   loop @@Do
   ;--------------
	ret
MemSet endp