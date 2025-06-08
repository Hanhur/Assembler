
PLAYER_W = 50
PLAYER_H = 50

.data
	x			dd 10
	y			dd 100
	w			dd PLAYER_W
	h			dd PLAYER_H	
	speed		dd 4
	direction	dd 0
	
.code
draw_player proc uses ebx esi edi hdc:DWORD
	LOCAL hBrush:DWORD
	LOCAL oldBrush:DWORD
	;----------------------------
	fnx hBrush = CreateSolidBrush, 0000FF00h
	;----------------------------
	fnx oldBrush = SelectObject, hdc, hBrush
	;----------------------------
	mov eax, x
	add eax, PLAYER_W
	mov edx, y
	add edx, PLAYER_H
	;---------------------------
	fn Rectangle, hdc, x, y, eax, edx
	;---------------------------
	fn SelectObject, hdc, oldBrush
	;---------------------------
	fn DeleteObject, hBrush
	;---------------------------
	Ret
draw_player endp
;=============== Dvizhenie Igroka ===============
;EAX --> hWin
;================================================
player_move proc uses ebx esi edi
	mov eax, direction
	or eax, eax
	je @@Ret
	;---------------------
	cmp eax, 44h ;D
	jne @F
	;---------------------
	call player_move_right
	;---------------------
	jmp @@Ret
@@:
	cmp eax, 41h ;A
	jne @F
	;---------------------
	call player_move_left
	;---------------------
	jmp @@Ret
@@:
	cmp eax, 57h ;W
	jne @F
	;--------------------
	call player_move_up
	;--------------------
	jmp @@Ret
@@:
	cmp eax, 53h ;S
	jne @@Ret
	;-------------------
	call player_move_down
	;-------------------
@@Ret:
	Ret
player_move endp
;===================================
player_move_right proc
	mov eax, x
	mov edx, speed
	add eax, edx
	mov ecx, eax
	;----------------------
	add eax, PLAYER_W
	cmp eax, dword ptr[esi + 8]
	jg @@Ret
	;----------------------
	mov x, ecx
	;----------------------
@@Ret:
	Ret
player_move_right endp
;====================
player_move_down proc
	mov eax, y
	mov edx, speed
	add eax, edx
	mov ecx, eax
	;----------------------
	add eax, PLAYER_H
	cmp eax, dword ptr[esi + 0Ch]
	jg @@Ret
	;----------------------
	mov y, ecx
	;----------------------
@@Ret:
	Ret
player_move_down endp
;====================
player_move_left proc
	mov eax, x
	mov edx, speed
	sub eax, edx
	mov ecx, eax
	;----------------------
	or eax, eax
	jle @@Ret
	;----------------------
	mov x, ecx
	;----------------------
@@Ret:
	Ret
player_move_left endp
;====================
player_move_up proc
	mov eax, y
	mov edx, speed
	sub eax, edx
	mov ecx, eax
	;----------------------
	or eax, eax
	jle @@Ret
	;----------------------
	mov y, ecx
	;----------------------
@@Ret:
	Ret
player_move_up endp
;====================
;EAX --> Key
;====================
player_key_down proc

	cmp eax, 44h ;D
	je @@Done
	;----------------
@@:
	cmp eax, 41h ;A
	je @@Done
	;----------------
	cmp eax, 57h ;W
	je @@Done
	;----------------
	cmp eax, 53h ;S
	jne @@Ret
	;----------------
@@Done:
	mov direction, eax
	;----------------
@@Ret:
	Ret
player_key_down endp
;====================
;EAX --> Key
;====================
player_key_up proc

	cmp eax, 44h ;D
	je @@Done
	;----------------
	cmp eax, 41h ;A
	je @@Done
	;---------------
	cmp eax, 57h ;W
	je @@Done
	;----------------
	cmp eax, 53h ;S
	jne @@Ret
	;----------------
@@Done:
	and direction, 0
@@Ret:
	Ret
player_key_up endp