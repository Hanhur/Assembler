; Opisanie modeli pamayti
.686
.model flat, stdcall
option casemap:none
;====================================
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
;====================================
;Constant
.const
	FPS equ 1000
	
; Sekcie data
.data
	numberA db 10 ; +0
	numberB dd 11 ; +1
	numberC dd 12 ; +3
	;numbreD dq 13 ; +12
	;littleEndians dd 12345678h
	
.data?
	hInstance dd ?
	
; Sekcie koda
.code
start:
	;mov eax, littleEndians
	;----------------
	mov hInstance, -1
	;---------------
	push FPS
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