; Opisanie modeli pamyati
.686
.model flat, stdcall
option casemap:none
;====================================
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
;====================================
; Sekcie koda
.code
start:
	push 3000
	;---------------
	; function Sleep, zaderzhka 3000 milisekund
	call Sleep
	;---------------
	; push, peredacha parametra i pomichenie v steck
	push 0 
	;---------------
	; call vyzov function
	call ExitProcess
	;---------------
	; lesson 4
end start