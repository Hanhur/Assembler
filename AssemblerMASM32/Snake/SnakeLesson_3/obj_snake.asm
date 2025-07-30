
DrawSnake	proto :DWORD, :DWORD
DrawTail	proto
ClearTail	proto


SNAKE struct
	x			dword ?
	y			dword ?
	direction	db ?
				db ?
	speed		dword ?
SNAKE ends
;-------------------------

TAIL struct
	x	dword ?
	y	dword ?
TAIL ends


.const
	MAX_SPEED	equ 10
	MAX_TAIL	equ 500
	
	
.data?
	snake	SNAKE <>
	tail	TAIL MAX_TAIL dup(<>)
	spd_count	dd ?
	nTail		dd ?

	
.code
;============== Draw Snake =====================
DrawSnake proc uses ebx esi edi x:DWORD, y:DWORD
	fn gotoxy, x, y
	;--------------------------
	fn SetColor, cLightCyan
	;--------------------------
	fn crt_putchar, 'O'
	;--------------------------
	Ret
DrawSnake endp
;================= Draw Tail =====================
DrawTail proc uses ebx esi edi
	fn SetColor, cLightCyan
	;-------------------------
	lea esi, tail
	;-------------------------
	xor ebx, ebx
	jmp @@For
		@@In:
			mov eax, dword ptr[esi]
			mov ebx, dword ptr[esi + 4]
			;--------------------------
			.if eax == 0 || ebx == 0
				jmp @@Ret
			.endif
			;--------------------------
			fn gotoxy, eax, ebx
			;--------------------------
			fn crt_putchar, 'o'
	;-------------------------
	inc ebx
	add esi, sizeof TAIL
	@@For:
		cmp ebx, nTail
		jb @@In
	;-------------------------
	@@Ret:
		Ret
DrawTail endp
;================= Clear Tail ====================
ClearTail proc uses ebx esi edi
	lea esi, tail
	;--------------------------
	xor ebx, ebx
	;--------------------------
	jmp @@For
		@@In:
			mov dword ptr[esi], 0
			mov dword ptr[esi + 4], 0
	;---------------------------
	add esi, sizeof TAIL
	inc ebx
	@@For:
		cmp ebx, nTail
		jb @@In
	Ret
ClearTail endp