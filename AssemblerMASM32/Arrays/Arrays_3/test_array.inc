
.data
;--------------------------
;    integer array
;--------------------------
dword_array       dd 7,6,5,4,3,2,1
arr_size          dd $-dword_array

.code
;==================================================
test_array proc uses ebx esi edi

    fn set_console_color,6,0
    ;--------------
    printf("Initial array %c ",62)
    ;--------------
    lea esi,dword_array
    ;--------------
    mov ebx,arr_size
    shr ebx,2 ; shr delenie na 4
    ;--------------
    fn print_array,esi,ebx
    ;--------------
    lea edx,dword ptr[esi+ebx*4]
    ;--------------
    fn find_min_value_ex,esi,edx
    ;--------------
    printf("Min value = %d\n",eax)
    ;--------------
	ret
test_array endp
;=============================================