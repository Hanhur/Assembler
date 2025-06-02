calculator  proto

.data
;------------------------------------------------------
msgMenu     db "+++++++++++++++++++++++++++++++++++++++",13,10
            db "   Base calculator Beginner's Guide",13,10
            db "+++++++++++++++++++++++++++++++++++++++",13,10,0
;------------------------------------------------------
msg1        db "Enter the first number:",62,20h,0
msg2        db "Enter the second number:",62,20h,0
msgOperator db "Enter the operator (+, -, *, /):",62,20h,0
;------------------------------------------------------
msgPromt    db 13,10,"Press 'q' to quit, or 'ENTER' to continue:",62,20h,0
msgInvalid  db "Invalid input. Please try again.",13,10,0

.code
calculator proc uses ebx esi edi
    LOCAL number1:DWORD
    LOCAL number2:DWORD
    LOCAL operator:DWORD
    LOCAL buffer[12]:BYTE
    
    fn StdOut, addr msgMenu
    ;-------------------
@@Input:
    
    and operator,0
    lea ebx, buffer
    
    ;-------------------
    ;Print Prompt
    ;-------------------
    
    fn StdOut, addr msgPromt
    ;-------------------
    fn StdIn, ebx, 12
    ;-------------------
    mov al,byte ptr[ebx]
    cmp al,'q'
    je @@Ret
    
    ;-------------------
    ;Enter First Number
    ;-------------------
    
    fn StdOut, addr msg1
    ;-------------------
    fn StdIn, ebx, 12
    ;-------------------
    call atoi
    ;-------------------
    mov number1,eax
    
    ;-------------------
    ;Enter Second Number
    ;-------------------
    
    fn StdOut, addr msg2
    ;-------------------
    fn StdIn, ebx, 12
    ;-------------------
    call atoi
    ;-------------------
    mov number2,eax
    
    ;-------------------
    ;Enter Operator
    ;-------------------
    
    fn StdOut, addr msgOperator
    ;-------------------
    fn StdIn, addr operator,4
    ;-------------------
    
    movzx eax,byte ptr[operator]
    ;-------------------
    cmp al,'+'
    je @@Add
    ;-------------------
    cmp al,'-'
    je @@Sub
    ;-------------------
    cmp al,'*'
    je @@Mul
    ;-------------------
    cmp al,'/'
    je @@Div
    ;-------------------
    fn StdOut, addr msgInvalid
    ;-------------------
    jmp @@Input
@@Add:
    mov eax,number1
    add eax,number2
    ;---------------
    printf("Result: %d\n", eax)
    ;---------------
    jmp @@Input
    
@@Sub:

    mov eax,number1
    sub eax,number2
    ;---------------
    printf("Result: %d\n", eax)
    ;---------------
    jmp @@Input
@@Mul:
    mov eax,number1
    imul eax,number2
    ;--------------
    printf("Result: %d\n", eax)
    ;---------------
    jmp @@Input
@@Div:
    mov eax,number1
    cdq
    mov ecx,number2
    idiv ecx
    ;---------------
    printf("Result is: Quotient = %i Remainder = %i\n", eax, edx)
    ;---------------
    jmp @@Input
@@Ret:

	ret
calculator endp
;===========================
atoi proc

    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    xor eax,eax
    xor edi,edi
    ;-------------
    mov esi,ebx
    xor ebx,ebx
    mov ecx, 10
@@For:
    mov bl, byte ptr [esi]
    cmp bl,'-'
    jne @F
    ;-------------
    inc edi
    inc esi
    mov bl,byte ptr[esi]
@@:
    or bl, bl
    je @@Ret
    ;-------------
    cmp bl,'0'
    jl @F
    ;-------------
    cmp bl,'9'
    jg @F
    ;-------------
    sub bl,30h
    mul ecx
    add eax,ebx
    ;-------------
    inc esi
    jmp @@For

@@:
    xor eax,eax
@@Ret:
    or edi,edi
    je @F
    ;------------
    neg eax 
@@:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx

	ret
atoi endp