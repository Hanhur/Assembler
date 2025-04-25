include main.inc	
;=============================

.code
start:
	call main
	;---------------
	push eax
	;---------------
	call ExitProcess
;==============================
main proc
	printf("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n")
	printf("Buffer Overflow as type of Vulnerability Tutorial by Tempesta\n")
	printf("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n")
	;------------
	call exploit
	;------------
	inkey
	;------------
	xor eax, eax
	;------------
	Ret
main endp
end start