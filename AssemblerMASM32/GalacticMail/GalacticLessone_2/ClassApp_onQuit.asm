ClassApp_onQuit		proto

.code
ClassApp_onQuit proc uses ebx esi edi
	call dword ptr[fRoomQuit]
	;---------------------------------
	fn DeleteObject, background
	;---------------------------------
	fn SelectObject, screen, bmpOld
	;---------------------------------
	fn DeleteDC, screen
	fn DeleteObject, screenBmp
	;---------------------------------
	fn ReleaseDC, hWnd, window
	;---------------------------------
	Ret
ClassApp_onQuit endp