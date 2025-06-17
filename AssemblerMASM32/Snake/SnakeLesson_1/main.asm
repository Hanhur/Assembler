include main.inc
include engine.asm
include interface.asm


.code
start:
	fn SetConsoleTitle, "Snake demo" ;Vyvodim title
	;-----------------
	fn SetWindowSize, MAX_WIDTH, MAX_HEIGHT
	;----------------
	fn HideCursor
	;----------------
	fn Main
	;----------------
	fn SetConsoleTextAttribute, rv(GetStdHandle, -11), cLightRed
	;----------------
	inkey
	;----------------
	call ExitProcess
;====================
Main proc

	fn MainMenu
	;----------------
	.while closeConsole == 0
		.while gameOver == 1

		.endw
		;------------
		fn MainMenu
	.endw
	;-----------------
	fn gotoxy, 25, 40
	Ret
Main endp
;=============== Izmenenie poziciji Cursora ================
gotoxy proc uses ebx esi edi x:DWORD, y:DWORD
	mov ebx, y
	shl ebx, 16
	or ebx , x
	;--------------------------
	fn SetConsoleCursorPosition, rv(GetStdHandle, -11), ebx
	;--------------------------
	Ret
gotoxy endp
;================================
HideCursor proc uses ebx esi edi
	LOCAL ci:CONSOLE_CURSOR_INFO
	;---------------------------
	fn GetStdHandle, -11
	;---------------------------
	push eax
	lea ebx, ci
	;---------------------------
	fn GetConsoleCursorInfo, eax, ebx
	;---------------------------
	mov ci.bVisible, 0
	;---------------------------
	pop eax
	;---------------------------
	fn SetConsoleCursorInfo, eax, ebx
	;---------------------------
	Ret
HideCursor endp
;================= Function dlya izmeneniya shiriny akoshechka console ===================
SetWindowSize proc uses ebx esi edi wd:DWORD, ht:DWORD
	fn GetStdHandle, -11
	;------------------------------
	push eax
	;------------------------------
	mov ebx, ht
	shl ebx, 16
	;------------------------------
	or ebx, wd
	;------------------------------
	fn SetConsoleScreenBufferSize, eax, ebx
	;------------------------------
	pop eax
	;------------------------------
	fn SetConsoleWindowInfo, eax, 1, offset srect
	;------------------------------
	Ret
SetWindowSize endp
end start