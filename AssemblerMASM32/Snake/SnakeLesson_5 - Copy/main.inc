include \masm32\include\masm32rt.inc
include \masm32\include\winmm.inc
include minifmod\mfmplayer.inc
;====================================
includelib \masm32\lib\winmm.lib
includelib minifmod\mfmplayer.lib
;====================================
include xm.asm
include RangedRand.asm

Main			proto

.const
	MAX_WIDTH 	equ 82
	MAX_HEIGHT 	equ 42




.data?




.data
	srect	SMALL_RECT <0, 0, 81, 41>
	szClick db "Res\Click.wav", 0
	szFruit db "Res\Treasure.wav", 0
	szLose	db "Res\Lose.wav", 0
	szCls	db "cls", 0