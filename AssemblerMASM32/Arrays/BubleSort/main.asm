include main.inc
    
.code
start:
    call main
    ;-----------
    push eax
    ;-----------
    call ExitProcess
;============================
main proc

    call init
    
    ;--------------
    ;   For Test
    ;--------------
    call test_char_array
    call test_array
    ;--------------
    putchars 13,10
    ;--------------
    inkey
    ;--------------
    xor eax,eax
    
	ret
main endp
    
end start