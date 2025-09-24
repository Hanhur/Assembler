comment~ ===========================================================================
					Console Game Library
===================================================================================~


.686P                                     ; create 32 bit code
.mmx
.xmm
.model flat, stdcall                      ; 32 bit memory model
option casemap :none                      ; case sensitive 

;     include files
;     ~~~~~~~~~~~~~
include \masm32\include\windows.inc       ; main windows include file
include \masm32\include\masm32.inc        ; masm32 library include

; -------------------------
; Windows API include files
; -------------------------
include \masm32\include\gdi32.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\Comctl32.inc
include \masm32\include\comdlg32.inc
include \masm32\include\shell32.inc
include \masm32\include\oleaut32.inc
include \masm32\include\ole32.inc
include \masm32\include\msvcrt.inc
include \masm32\include\fpu.inc
include \masm32\include\winmm.inc
include \masm32\minifmod\mfmplayer.inc

include \masm32\macros\macros.asm         ; masm32 macro file

;     libraries
;     ~~~~~~~~~
includelib \masm32\lib\masm32.lib         ; masm32 static library
includelib \masm32\lib\winmm.lib
includelib \masm32\minifmod\mfmplayer.lib

; ------------------------------------------
; import libraries for Windows API functions
; ------------------------------------------
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\Comctl32.lib
includelib \masm32\lib\comdlg32.lib
includelib \masm32\lib\shell32.lib
includelib \masm32\lib\oleaut32.lib
includelib \masm32\lib\ole32.lib
includelib \masm32\lib\msvcrt.lib
includelib \masm32\lib\fpu.lib

;========================================= Prototypes of Function =================================
GamePause				proto :DWORD, :DWORD
SetConsoleWindowSize	proto :DWORD, :DWORD
HideConsoleCursor		proto 
;-----------------------------------------------
gotoxy					proto :DWORD, :DWORD
SetConsoleColor			proto :DWORD
CheckCursorPosition 	proto :DWORD, :DWORD
;-----------------------------------------------
DrawLevel				proto :DWORD, :DWORD
DrawScore				proto :DWORD, :DWORD, :DWORD, :DWORD
Play_sound				proto :DWORD
RangedRand 				proto :DWORD, :DWORD
Keyboard_check_pressed	proto
Keyboard_check			proto

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
.data
	rand_max dq 32768.0
