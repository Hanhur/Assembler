ClassApp_onInit		proto

.code
;====================== ClassApp_onInit =====================
ClassApp_onInit proc uses ebx esi edi
	LOCAL dwReturnValue:DWORD
	;---------------------------------
	mov dword ptr[dwReturnValue], 1
	;---------------------------------
	fn SetConsoleTitle, "Galactic Mail v1.0"
	;---------------------------------
	fn SetConCursor, 0
	;---------------------------------
	fn SetConsoleWindowSize, ROOM_WIDTH, ROOM_HEIGHT
	;---------------------------------
	fn SetConsoleCenterScreen, HWND_TOP
	;---------------------------------
	fn GetModuleHandle, 0
	;---------------------------------
	mov dword ptr[hInstance], eax
	;---------------------------------
	;fn GetConcoleHwnd
	;---------------------------------
	mov dword ptr[hWnd], eax
	;---------------------------------

	;---------------------------------
	mov eax, dword ptr[dwReturnValue]
	Ret
ClassApp_onInit endp