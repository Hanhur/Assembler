

GameInit				proto
DrawLevel				proto :DWORD
Play_sound				proto :DWORD
Keyboard_check_pressed	proto
Keyboard_check			proto
GameController			proto
KeyEvent				proto


.const
;---------------- Keys -------------------
	KEY_ENTER	equ 13
	KEY_ESC		equ 27


.data
	bKey			db 30h ;'0'
	gameOver		db 0
	closeConsole	db 0
	nLevel			db 1
	score			dd 0
;------------------------------------------
	szLevel_1		db "level_1.txt", 0




.code
;================= Game Controller ===============
GameController proc uses ebx esi edi
	fn KeyEvent




	Ret
GameController endp
;================= Game Init =====================
GameInit proc uses ebx esi edi
	movzx eax, byte ptr[nLevel]
	fn DrawLevel, eax
	;---------------------------
	or eax, eax
	;---------------------------
	je @@Error
	;---------------------------
	; 	Object Snake Init
	;---------------------------
	mov dword ptr[snake.x], 40
	mov dword ptr[snake.y], 20
	mov byte ptr[snake.direction], 30h
	mov dword ptr[snake.speed], MAX_SPEED
	;---------------------------
	mov dword ptr[score], 0
	;---------------------------
	fn DrawSnake, snake.x, snake.y
	;---------------------------
	
	


	;---------------------------
	@@Ret:
		Ret
	;--------------------------
	@@Error:
		mov byte ptr[closeConsole], 1
		mov byte ptr[gameOver], 0
		;----------------------
		fn gotoxy, 32, 19
		;----------------------
		fn SetConsoleTextAttribute, rv(GetStdHandle, -11), cBrown
		;----------------------
		fn crt_puts, "Load File failed"
		;----------------------
		fn Sleep, 2000
		jmp @@Ret
GameInit endp
;================= Key Event =====================
KeyEvent proc uses ebx esi edi
	fn Keyboard_check
	;-------------------------
	.if byte ptr[bKey] == KEY_ESC
		mov byte ptr[gameOver], 0
		mov byte ptr[closeConsole], 1
		;---------------------
	.elseif byte ptr[bKey] == 'p'
	
	
	.elseif byte ptr[bKey] == 'w' || byte ptr[bKey] == 's' || byte ptr[bKey] == 'a' || byte ptr[bKey] == 'd'
		mov byte ptr[snake.direction], al
	.endif
	Ret
KeyEvent endp
;================= Keyboard_check ================
Keyboard_check proc uses ebx esi edi
	mov byte ptr[bKey], 30h
	;-------------------------------
	fn crt__kbhit
	;-------------------------------
	or eax, eax
	;-------------------------------
	je @@Ret
	fn crt__getch
	;-------------------------------
	mov byte ptr[bKey], al
	;-------------------------------
	@@Ret:
		Ret
Keyboard_check endp
;================= Draw Level ====================
DrawLevel proc uses ebx esi edi nLvl:DWORD
	LOCAL hFile:DWORD
	LOCAL buffer[256]:BYTE
	;------------------------------
	.if nLvl == 1
		fn crt_fopen, offset szLevel_1, "r"
		;--------------------------
		or eax, eax
		je @@Ret
		;--------------------------
		mov dword ptr[hFile], eax
		;--------------------------
		push eax
		;--------------------------
		fn SetConsoleTextAttribute, rv(GetStdHandle, -11), cLightYellow
		;--------------------------
		lea ebx, buffer
		;--------------------------
		@@While:
			fn crt_fgets, ebx, 256, hFile
			;----------------------
			or eax, eax
			;----------------------
			je @@CloseFile
			;----------------------
			fn crt_printf, eax
			jmp @@While
		;--------------------------
		@@CloseFile:
			pop eax
			;----------------------
			fn crt_fclose, eax
			;----------------------
			mov eax, 1
	.endif
	;------------------------------
	@@Ret:
		Ret
DrawLevel endp
;================= Nazhatie klavishi ==============
Keyboard_check_pressed proc uses ebx esi edi
	fn FlushConsoleInputBuffer, rv(GetStdHandle, -10)
	;---------------------------------------
	@@:
		fn Sleep, 1000
		fn crt__kbhit ; Proverajet nazatie klavishi
		;----------------
		or eax, eax
		je @B ;Nazad (Back)
		;----------------
		fn crt__getch ; Vozvrat nazaty symbol iz registra eax
		;----------------
		mov byte ptr[bKey], al
		;----------------
	Ret
Keyboard_check_pressed endp
;============================================
Play_sound proc uses ebx esi edi lpFile:DWORD
	
	fn PlaySound, lpFile, 0, SND_FILENAME or SND_ASYNC

	Ret
Play_sound endp