.686
.model flat, stdcall
option casemap:none
;=====================
include \masm32\include\windows.inc

include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib


include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

include \masm32\macros\macros.asm

.code
start:
     call main
     ;---------------
     push eax
     call ExitProcess
;=====================
main proc


    ; Example 1: Multiplication using IMUL
    ;-------------------------------------
 
    mov eax, -5            ; Load -5 into AX
    mov ebx, 7             ; Load 7 into BX
    imul eax, ebx           ; Multiply AX by BX, result in AX
    
    ;--------------------------------
    ; Now AX contains the result (-35)
    ;--------------------------------
    
    ;movsx eax,ax
    ;------------
    printf("Imul result is: %i\n", eax)

    ;--------------------------------
    ; Example 2: Division using DIV
    ;--------------------------------
    
    mov eax, 50            ; Load 50 into AX
    mov ecx, 2             ; Load 2 into CX (divisor)
    cdq
    div ecx                ; Divide AX by CX, quotient in AX, remainder in DX
    
    ;-----------------------------------------------------
    ; AX contains quotient (25), DX contains remainder (0)
    ;-----------------------------------------------------
    
    ;movzx eax,ax
    ;movzx edx,dx
    ;-----------
    printf("Div result is: Quotient = %u Remainder = %u\n", eax, edx)

    ;--------------------------------------
    ; Example 3: Signed Division using IDIV
    ;--------------------------------------
    
    mov eax, -50           ; Load -50 into AX (signed value)
    mov ebx, 3             ; Load 3 into CX (divisor)
    cdq
    idiv ebx               ; Signed division, quotient in AX, remainder in DX
    
    ;-------------------------------------------------------
    ; AX contains quotient (-16), DX contains remainder (-2)
    ;-------------------------------------------------------

    ;movsx eax, ax
    ;movsx edx, dx
    ;-----------
    printf("IDiv result is: Quotient = %d Remainder = %i\n", eax, edx)


    push 5
    push 30
    ;---------------
    call calculateGCD
    ;---------------
    printf("GDC is: %d\n", eax)

    push 5
    ;---------------
    call factorial
    ;---------------
    printf("Factorial is: %d\n", eax)
    ;---------------
    inkey
    xor eax,eax
	ret
main endp
;=====================
;while (b != 0) 
;{
   ;int temp = b;
   ;b = a % b;
   ;a = temp;
;}
;=====================
calculateGCD proc

    push ebp
    mov ebp,esp
    ;------------
    push ebx
    push esi
    push edi
    ;------------
    mov eax,dword ptr[ebp+8]   ; move the first number to eax
    cmp eax,0
    jge @F
    
    ;--------------------------------
    ;Ensure both numbers are positive
    ;--------------------------------
    
    neg eax
@@:
    mov ebx,dword ptr[ebp+0Ch] ; move the second number to ebx
    cmp ebx,0
    je @@Ret
    ;------------
    jg @@For
    ;------------
    neg ebx

@@For:
    cmp eax, ebx               ; compare the two numbers
    jg @F                      ; jump to the divide label if the first number is greater
    ;------------
    xchg eax, ebx              ; if ebx is greater, swap the numbers

@@:
    xor edx, edx               ; clear edx to prepare for the division
    div ebx                    ; divide eax by ebx, quotient in eax, remainder in edx
    cmp edx, 0                 ; compare remainder with 0
    je @@Ret                   ; if remainder is 0, jump to fin label
    ;------------
    mov eax, ebx               ; move ebx to eax for the next iteration
    mov ebx, edx               ; move edx to ebx for the next iteration
    jmp @@For

    ;------------
@@Ret:
    mov eax,ebx
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp
    
	ret 8
calculateGCD endp
;=====================
factorial proc
    
    push ebp
    mov ebp,esp
    ;------------
    push ebx
    push esi
    push edi
    ;------------
    mov eax,dword ptr[ebp+8]
    cmp eax,0
    jne @F
    ;-----------
    mov eax,1
    jmp @@Ret
    ;-----------
    cmp eax,1
    je @@Ret
    
    ;------------------------------------
    ; Initialize ECX for the loop counter
    ;------------------------------------
    
@@:
    mov ecx, eax
    mov eax,1

@@:
   ;----------------------------------------------
   ; Multiply the result by the loop counter (ECX)
   ;----------------------------------------------
    
   imul eax,ecx

   ;---------------------------
   ; Decrement the loop counter
   ;---------------------------
   
   dec ecx

   ;-------------------------------------------------
   ; Continue the loop until the counter becomes zero
   ;-------------------------------------------------
   
   jne @B

    ;------------
@@Ret:
   pop edi
   pop esi
   pop ebx
   mov esp,ebp
   pop ebp
    
	ret 4
factorial endp
end start