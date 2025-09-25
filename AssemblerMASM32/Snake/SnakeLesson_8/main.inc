include \masm32\congamelib\congame.inc

includelib \masm32\congamelib\congame.lib

include xm.asm

Main			proto

.const
	MAX_WIDTH 	equ 82
	MAX_HEIGHT 	equ 42




.data?
	id_timer	dd ?



.data
	srect	SMALL_RECT <0, 0, 81, 41>
	szClick db "Res\Click.wav", 0
	szFruit db "Res\Treasure.wav", 0
	szLose	db "Res\Lose.wav", 0
	szCls	db "cls", 0