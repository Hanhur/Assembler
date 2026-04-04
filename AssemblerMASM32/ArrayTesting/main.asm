include main.inc

.code
start:
	call main
	;---------------------
	push eax
	;---------------------
	call ExitProcess
;==========================
main proc
	fn sum_two_smallest_numbers, offset array, ARRAY_COUNT
	;-------------------------------
	printf("%d", eax)
	;-------------------------------
	print chr$(13, 10)
	;-------------------------------
	inkey
	;-------------------------------
	xor eax, eax
	;-------------------------------
	Ret
main endp
end start