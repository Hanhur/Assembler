
Play_sound				proto :DWORD
Keyboard_check_pressed	proto


.const
;---------------- Keys -------------------
	KEY_ENTER	equ 13


.data
	bKey			db 30h ;'0'
	gameOver		db 0
	closeConsole	db 0




.code
;================= Nazatie klavishi ==============
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