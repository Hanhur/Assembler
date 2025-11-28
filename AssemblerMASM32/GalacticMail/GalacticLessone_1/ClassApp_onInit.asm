ClassApp_onInit		proto

.code
ClassApp_onInit proc uses ebx esi edi
	LOCAL dwReturnValue:DWORD
	;---------------------------------
	mov dword ptr[dwReturnValue], 1
	;---------------------------------
	fn SetConsoleTitle, "Galactick Mail v1.0"
	;---------------------------------
	fn SetConCursor, 0
	;---------------------------------
	fn SetConsoleWindowSize, WINDOW_WIDTH, WINDOW_HEIGHT
	;---------------------------------
	
	;---------------------------------
	mov eax, dword ptr[dwReturnValue]
	Ret
ClassApp_onInit endp