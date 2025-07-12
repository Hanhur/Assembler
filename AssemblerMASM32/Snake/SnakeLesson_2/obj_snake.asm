
DrawSnake	proto :DWORD, :DWORD


SNAKE struct
	x			dword ?
	y			dword ?
	direction	db ?
				db ?
	speed		dword ?
SNAKE ends
;-------------------------


.const
	MAX_SPEED	equ 10
	
	
.data?
	snake	SNAKE <>
	
	
.code
;============== Draw Snake =====================
DrawSnake proc uses ebx esi edi x:DWORD, y:DWORD
	fn gotoxy, x, y
	;--------------------------
	fn SetConsoleTextAttribute, rv(GetStdHandle, -11), cLightCyan
	;--------------------------
	fn crt_putchar, 'O'
	;--------------------------
	Ret
DrawSnake endp