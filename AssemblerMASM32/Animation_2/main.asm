include main.inc

.code
start:
	fnx hInstance = GetModuleHandle, 0 ;fnx -> modernizacie makrosa (fn)
	;-------------------
	fn WinMain, eax, 0, 0, SW_SHOWDEFAULT
	;-------------------
	fn ExitProcess, eax
;==================================================================
WinMain proc hInst:DWORD, hPevInst:DWORD, dwCmdL:DWORD, bShow:DWORD
	LOCAL msg:MSG
	
	;--------------------
	;	Register Class
	;--------------------
	
	call register_class
	;--------------------
	mov ebx, eax
	
	;--------------------
	;	Center Window
	;--------------------
	
	call get_xy
	
	;--------------------
	;	Create Windows
	;--------------------
	
	fn CreateWindowEx, 0, ebx, CADD("MASM32 Window"), WS_OVERLAPPEDWINDOW, eax, edx, WINDOW_W, WINDOW_H, 0, 0, hInst, 0
	;--------------------
	mov ebx, eax
	;--------------------
	fn ShowWindow, eax, bShow
	;--------------------
	fn UpdateWindow, ebx
	;--------------------
	lea ebx, msg
	;-------------------
	;.while TRUE
	@@:
		fn GetMessage, ebx, 0, 0, 0
		;----------------
		;.break .if(!eax)
		or eax, eax
		je @@Ret
		;----------------
		fn TranslateMessage, ebx
		;----------------
		fn DispatchMessage, ebx
	;.endw
		;-------------------
		jmp @B
	@@Ret:
		mov eax, msg.wParam
		;-------------------
		Ret
WinMain endp
;================================================================================
WinProc proc uses ebx esi edi hWin:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
	mov eax, uMsg
	;-----------------------
	.if eax == WM_DESTROY
		fn PostQuitMessage, 0
	.elseif eax == WM_CREATE
		mov eax, hWin
		;-----------------
		call on_create
	.elseif eax == WM_KEYDOWN
		mov eax, wParam
		;-----------------
		call player_key_down
	.elseif eax == WM_KEYUP
		mov eax, wParam
		;-----------------
		call player_key_up
	.elseif eax == WM_TIMER
		mov eax, hWin
		;------------------
		call game_update
	.elseif eax == WM_PAINT
		mov eax, hWin
		;-----------------
		call on_paint
	.else
		fn DefWindowProc, hWin, uMsg, wParam, lParam
		;-------------------
		jmp @@Ret
	.endif
	xor eax, eax
	@@Ret:
		Ret
WinProc endp
end start