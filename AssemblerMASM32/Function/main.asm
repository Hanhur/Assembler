include main.inc
;====================================

.code
start:
	call main
	;-------------------
	push eax
	;-------------------
	call ExitProcess
;=====================================
main proc	
	push 8
	push 7
	;-------------------
	call addNumbers
	;-------------------
	push 3
	push 5
	;-------------------
	call calculate
	;-------------------
	push FPS
	;-------------------
	call Sleep
	;-------------------
	mov eax, 0
	Ret
main endp
end start