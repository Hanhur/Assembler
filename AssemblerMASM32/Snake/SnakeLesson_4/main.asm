include main.inc
include obj_fruit.asm
include obj_snake.asm
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
	exit
;====================
Main proc

	fn MainMenu
	;----------------
	.while closeConsole == 0
		;-------------------
		fn GameInit
		;-------------------
		.while gameOver == 1
			fn GameUpdate
			;---------------
			fn GameController
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
;================= Set Color ======================
SetColor proc uses ebx esi edi cref:DWORD
	
	fn SetConsoleTextAttribute, rv(GetStdHandle, -11), cref

	Ret
SetColor endp
;======================= Check Position ====================
CheckPosition proc uses ebx esi edi x:DWORD, y:DWORD
	LOCAL cRead:DWORD
	LOCAL buffer:DWORD
	;LOCAL cbi:CONSOLE_SCREEN_BUFFER_INFO
	;------------------------------
	mov dword ptr[buffer], 0
	;------------------------------
	fn gotoxy, x, y
	;------------------------------
	fn GetStdHandle, -11
	;------------------------------
	;push eax
	;------------------------------
	mov ebx, y
	shl ebx, 16
	or ebx, x
	;------------------------------
	;lea ebx, cbi
	;------------------------------
	;fn GetConsoleScreenBufferInfo, eax, ebx
	;------------------------------
	;mov ebx, cbi.dwCursorPosition ;koordinaty kursora
	;------------------------------
	lea edi, cRead ;address kolichestva schitanych simsolov
	;------------------------------
	lea esi, buffer ;address buffera
	;------------------------------
	fn GetStdHandle, -11
	;------------------------------
	;pop eax
	;------------------------------
	fn ReadConsoleOutputCharacter, eax, esi, 1, ebx, edi
	;------------------------------
	mov eax, dword ptr[buffer]
	;------------------------------
	Ret
CheckPosition endp
end start