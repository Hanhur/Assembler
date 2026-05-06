include \masm32\include\masm32rt.inc
include solution.inc

;===============================================================================
;Complete the solution function so that it splits the string into pairs of two characters. 
;If the string contains an odd number of characters then it should replace 
;the missing second character of the final pair with an underscore ('_').

;Examples:

;'abc' =>  ['ab', 'c_']
;'abcdef' => ['ab', 'cd', 'ef']

;The Function Returns a pointer to an array of string pointers.
;The last element of the array is NULL
;================================================================================

show_solution   proto :DWORD
delete_solution proto :DWORD

.data
	even_str    db "abcdef", 0
	odd_str     db "abc", 0

.code
show_solution proc uses ebx esi edi vector:DWORD

    push vector
    pop esi
    ;------------
    xor ebx, ebx
@@For:
    push dword ptr[esi + ebx * 4]
    pop eax
    or eax, eax
    je @@Ret
    ;-------------
    push eax
    ;-------------
    print chr$(22h)
    ;-------------
    pop eax
    printf("%s", eax)
    ;-------------
    print chr$(22h, 3Bh, 20h)
    inc ebx
    jmp @@For
    
@@Ret:
    print chr$(13, 10)
    ;-------------
	ret
show_solution endp
;=================================================================================
delete_solution proc uses ebx esi edi vector:DWORD

    push vector
    pop esi
    ;------------
    xor ebx, ebx
@@For:
    push dword ptr[esi + ebx * 4]
    pop eax
    or eax, eax
    je @@Ret
    ;-------------
    fn GlobalFree, eax
    ;-------------
    inc ebx
    jmp @@For
@@Ret:
    fn GlobalFree, esi
	ret
delete_solution endp