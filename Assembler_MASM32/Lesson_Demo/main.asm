; Opisanie modeli pamayti
.686
.model flat, stdcall
option casemap:none
;====================================
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
;====================================
.data
	numberA dd 10
	numberB dd 11
	
.data?
	hInstance dd ?
	
; Sekcie koda
.code
start:
	mov hInstance, -1
	;---------------
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
end start