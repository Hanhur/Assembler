include main.inc

.code
start:
	call main
	;------------
	push eax
	;------------
	call ExitProcess
;=====================
main proc
	call menu
	;--------------
	xor eax, eax
	;--------------
	Ret
main endp
end start