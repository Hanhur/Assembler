include main.inc
include ClassApp.asm



.code
start:
	fn HideConsole
	;--------------------
	fn Main
	;--------------------
	fn ExitProcess, eax
	;--------------------
;=========== Main =============
Main proc
	;---------------------
	fn ClassApp_onExecute
	;---------------------
	Ret
Main endp
end start