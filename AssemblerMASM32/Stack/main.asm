.686
.model flat, stdcall
option casemap:none
;====================================
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
;====================================

FPS = 1000
;====================================

.data
;====================================
;		Stack Emulation
;====================================
	StackBottom		dd 0
					dd 0
					dd 0
					dd 0
	StackTop		dd 0
	StackPointer	dd offset StackTop
	
	number1			dd 0
	number2			dd 0


.code
start:
comment~
	mov ebp, StackPointer
	
	;------------------------
	; Push a value in stack
	;------------------------
	
	; sub vychitanie
	sub ebp, 4
	mov dword ptr[ebp], 1
	;------------------------
	sub ebp, 4
	mov dword ptr[ebp], 2
	;------------------------
	sub ebp, 4
	mov dword ptr[ebp], 3
	;------------------------
	sub ebp, 4
	mov dword ptr[ebp], 4
	
	;------------------------
	; Pop a value from stack
	;------------------------
	
	; add pribavit
	mov eax, dword ptr[ebp]
	add ebp, 4
	;------------------------
	mov ecx, dword ptr[ebp]
	add ebp, 4
	;------------------------
	mov edx, dword ptr[ebp]
	add ebp, 4
	;------------------------
	mov ebx, dword ptr[ebp]
	add ebp, 4
	;------------------------
	
	push 4
	push 3
	push 2
	push 1
	;------------------------
	pop eax
	pop ecx
	pop edx
	pop ebx
	;------------------------
~
	push 2 
	push 1
	;------------------------
	pop number1
	pop number2
	;------------------------
	push number2
	push number1
	;------------------------
	pop number2
	pop number1
	;------------------------
	push FPS
	;------------------------
	call Sleep
	;------------------------
	push 0
	;------------------------
	call ExitProcess
end start