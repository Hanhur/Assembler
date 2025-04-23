.686
.model flat, stdcall
option casemap:none
;====================================
include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib
;====================================

FPS = 1000
;====================================

.code
start:
	push 8
	push 7
	;-------------------
	call addNumbers
	;-------------------
	push FPS
	;-------------------
	call Sleep
	;-------------------
	push 0
	;-------------------
	call ExitProcess
;=====================================
addNumbers proc
	; Prolog function
	push ebp
	mov ebp, esp
	;-------------------
	; Telo function
	mov eax, dword ptr[ebp + 8]
	add eax, dword ptr[ebp + 0Ch]
	;-------------------
	; Epilog function
	mov esp, ebp
	pop ebp
	;-------------------
	Ret 8
addNumbers endp	
end start