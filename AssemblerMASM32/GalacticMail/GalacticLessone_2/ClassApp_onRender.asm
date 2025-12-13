ClassApp_onRender	proto

.code
ClassApp_onRender proc uses ebx esi edi
	call dword ptr[fRoomRender]
	;----------------------------------
	fn BitBlt, window, 0, 0, ROOM_WIDTH, ROOM_HEIGHT, screen, 0, 0, 00CC0020h
	;----------------------------------
	Ret
ClassApp_onRender endp