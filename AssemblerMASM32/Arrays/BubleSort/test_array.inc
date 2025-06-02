include array_utils.inc

.data
;--------------------------
;      string array
;--------------------------
char_array  db "MASM32 Macro Assembler",0   ;lens 22

;--------------------------
;      byte array
;--------------------------
byte_array  db 4Dh,41h,53h,4Dh,33h,32h,20h,4Dh,61h,63h,72h,6Fh,20h,41h,73h,73h,65h,6Dh,62h,6Ch,65h,72h,0

;--------------------------
;    integer array
;--------------------------
dword_array       dd 4,3,2,1   ;size = 4  = 4*4 = 16 byte

.code
;======================================================
test_array proc uses ebx esi edi

    lea esi,dword_array
    ;-------------------
    fn print_array,esi,4
    ;-------------------
    fn bubble_sort,esi,4
    ;-------------------
    fn print_array,esi,4
    ;-------------------
    fn bubble_sort,esi,4
    ;-------------------





	ret
test_array endp
;====================================================
test_char_array proc uses ebx esi edi

    ;--------------
    mov esi,offset byte_array
    ;---------------
    printf("Full character array: %s\n",esi)
    ;---------------
    mov al,byte ptr[esi]
    ;---------------
    printf("Character at index 0:  %c\n",eax)
    ;---------------
    mov al,byte ptr[esi+0Dh]
    ;---------------
    printf("Character at index 13: %c\n",eax)
    ;---------------
    mov al,byte ptr[esi+15h]
    ;---------------
    printf("Character at index 21: %c\n",eax)
    ;---------------
    call slen
    ;---------------
    printf("Char array length: %u\n",eax)
    ;---------------
    call char_to_ascii
    ;---------------
    mov esi,offset byte_array
    ;---------------
    printf("Full Byte array: %s\n",esi)
    ;---------------
    call local_char

	ret
test_char_array endp
;==================================================
;ESI --> Pointer to String
;==================================================
slen proc
    
    or eax,0FFFFFFFFh

@@:
    inc eax
    mov dl,byte ptr[esi+eax]
    or dl,dl
    test byte ptr[esi+eax],0FFh
    jne @B

	ret
slen endp
;==================================================
char_to_ascii proc uses ebx

    or ebx,0FFFFFFFFh
@@:
    inc ebx
    movzx eax,byte ptr[esi+ebx]
    or al,al
    je @@Ret
    ;-------------
    printf("%X,",eax)
    ;-------------
    jmp @B
    ;-------------
@@Ret:
    xor eax,eax
    ;-------------
    printf("%u\n",eax)
    ;-------------
   
	ret
char_to_ascii endp
;==================================================
local_char proc uses esi

     ;szText szMasm32,"MASM32"
     
    jmp @@L0
    ;---------------
    szMasm32 db 4Dh,41h,53h,4Dh,33h,32h,0

@@L0:
    mov esi,offset szMasm32
   
    ;---------------
    printf("Full Byte array: %s\n",esi)
    ;---------------

	ret
local_char endp
;==================================================