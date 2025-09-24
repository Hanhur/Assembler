include main.inc
include obj_fruit.asm
include obj_snake.asm
include engine.asm
include interface.asm


.code
start:
	fn SetConsoleTitle, "Snake demo" ;Vyvodim title
	;-----------------
	fn SetConsoleWindowSize, MAX_WIDTH, MAX_HEIGHT
	;----------------
	fn HideConsoleCursor
	;----------------
	fn Main
	;----------------
	exit
;====================
Main proc
	fn MainMenu
	;----------------
	fn LoadGameEvent
	;----------------
	.while closeConsole == 0
		;-------------------
		fn StartGameEvent
		;-------------------
		.while gameOver == 1
			
		.endw
		;------------
		fn MainMenu
		;--------------
		fn LoadGameEvent
	.endw
	;-----------------
	fn gotoxy, 25, 40
	Ret
Main endp
end start