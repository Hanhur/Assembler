include main.inc
.code
start:
     call main
     ;----------
     push eax
     call ExitProcess
;===========================
main proc

    ;fn dword_has_null_byte, 00343631h
    ;-------------
    ;printf("%x", eax)
    ;-------------
    ;print chr$(13, 10)
    
    fn str_len32, offset str2
    ;---------------
    fn mem_cpy32, offset str1, offset buffer, eax
    ;---------------
    fn str_cat32, offset buffer, offset str2
    ;----------------
    fn StdOut, eax
    
    ;printf("%x", eax)
    
    
    
    ;-------------
    print chr$(13, 10)
    ;-------------
    inkey
    ;-------------
    xor eax, eax
	ret
main endp
end start