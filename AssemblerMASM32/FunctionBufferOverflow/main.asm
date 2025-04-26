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
	;call exploit
	;------------
	;call exploit2
	;------------
	;call get_comp_info
	
	;------------
	;	Test
	;------------
	
	mov eax, 7FFFFFFFh
	mov edx, 1
	;------------
	;invoke simple_add, eax, edx
	;------------
	invoke int_add, eax, edx
	
	;------------
	; Print test result
	;------------
	
	printf("Result: %i\n", eax)
	
	;------------
	; Pause programm
	;------------
	
	inkey
	
	;------------
	; Exit code = 0
	;------------
	
	xor eax, eax
	;------------
	Ret
main endp
end start