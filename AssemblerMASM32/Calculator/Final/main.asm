include main.inc

.code
start:
     call main
     ;---------------
     push eax
     call ExitProcess
;=====================
main proc
    
     call calculator
     ;---------------
     xor eax,eax
	 ret
main endp
;====================
end start