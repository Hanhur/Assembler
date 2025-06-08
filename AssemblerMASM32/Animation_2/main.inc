include \masm32\include\masm32rt.inc

WINDOW_W = 640
WINDOW_H = 480
FPS		 = 40

;======================================
;				Modules
;======================================

include player.inc
include game.inc
include onCreate.inc
include onPaint.inc

WinMain		proto :DWORD, :DWORD, :DWORD, :DWORD

.data
	hInstance	dd 0 ;hInstance -> Deskriptor module
	szClassName db "Win32", 0
	
.code
register_class proc
	LOCAL wc:WNDCLASSEX
	;------------------
	mov wc.cbSize, sizeof wc
	mov wc.style, CS_HREDRAW or CS_VREDRAW
	mov wc.cbClsExtra, 0
	mov wc.cbWndExtra, 0
	mov eax, hInstance
	mov wc.hInstance, eax
	mov wc.hbrBackground, COLOR_WINDOW + 1
	mov wc.lpszMenuName, 0
	;-----------------
	fn LoadIcon, 0, IDI_APPLICATION
	;-----------------
	mov wc.hIconSm, eax
	mov wc.hIcon, eax
	;-----------------
	fn LoadCursor, 0, IDC_ARROW
	;-----------------
	mov wc.hCursor, eax
	;-----------------
	mov wc.lpszClassName, offset szClassName ;cfm$("Win32")
	;-----------------
	mov wc.lpfnWndProc, offset WinProc
	;-----------------
	fn RegisterClassEx, addr wc
	;-----------------
	Ret
register_class endp
;============================
get_xy proc uses ebx esi edi
	push 0
	push 1
	;-----------------------
	call GetSystemMetrics
	;-----------------------
	mov ebx, eax ;hscreen
	;----------------------
	call GetSystemMetrics
	;----------------------
	sub eax, WINDOW_W ;wscreen
	shr eax, 1
	mov edx, ebx
	sub edx, WINDOW_H
	shr edx, 1
	;----------------------
	Ret
get_xy endp