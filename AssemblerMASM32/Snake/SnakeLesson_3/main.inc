include \masm32\include\masm32rt.inc
include \masm32\include\winmm.inc
;====================================
includelib \masm32\lib\winmm.lib
;====================================

Main			proto
SetWindowSize	proto :DWORD, :DWORD
HideCursor		proto 
;-----------------------------------------------
gotoxy			proto :DWORD, :DWORD
SetColor		proto :DWORD
;===============================================
;    Background and foreground colors
;===============================================

cBlack        = 0
cBlue         = 1
cGreen        = 2
cCyan         = 3
cRed          = 4
cMagenta      = 5
cBrown        = 6
cLightGray    = 7
cDarkGray     = 8
cLightBlue    = 9
cLightGreen   = 10
cLightCyan    = 11
cLightRed     = 12
cLightMagenta = 13
cLightYellow  = 14
cWhite        = 15
cPanel        = 48
;=================================================

.const
	MAX_WIDTH 	equ 82
	MAX_HEIGHT 	equ 42




.data?




.data
	srect	SMALL_RECT <0, 0, 81, 41>
	szClick db "Res\Click.wav", 0