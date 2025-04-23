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
	buffer dq 0
		   dq 0
	;numberA db 10 ; +0
	;numberB dd 11 ; +1
	;numberC dd 12 ; +3
	;numbreD dq 13 ; +12
	;littleEndians dd 12345678h
	
.data?
	;hInstance dd ?
	
; Sekcie koda
.code
start:
	mov eax, 614D5341h
	mov ecx, 72657473h
	mov edx, 00002179h
	;-----------------
	; Preficks ptr -> Pointer (Ukazatel)
	mov dword ptr[buffer], eax
	mov dword ptr[buffer + 4], ecx
	mov dword ptr[buffer + 8], edx
	;-----------------
	; offset -> vychist oblast pamyati, i pomesti v register eax znachenie buffera 
	mov eax, offset buffer
	;-----------------
	mov eax, dword ptr[buffer] ;4 bit
	mov dx, word ptr[buffer + 4] ;2 bit
	mov cl, byte ptr[buffer + 6] ;1 bit
	;-----------------
	movzx eax, byte ptr[buffer]
	movzx edx, word ptr[buffer]
	;-----------------
	;mov eax, littleEndians
	;----------------
	;mov hInstance, -1
	;---------------
	;mov al, 78h
	;mov ah, 56h
	;mov ax, 5678h
	;mov eax, 12345678h
	;---------------
	;mov cl, 78h
	;mov ch, 56h
	;mov cx, 5678h
	;mov ecx, 12345678h
	;---------------
	;mov dl, 78h
	;mov dh, 56h
	;mov dx, 5678h
	;mov edx, 12345678h
	;---------------
	;mov bl, 78h
	;mov bh, 56h
	;mov bx, 5678h
	;mov ebx, 12345678h
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