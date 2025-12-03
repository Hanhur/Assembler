ClassApp_onStart	proto

.code
ClassApp_onStart proc uses ebx esi edi
	mov dword ptr[id_state], STATE_ROOM_FIRST
	;-----------------------------------------
	fn ClassRoom_LoadBackgroud, hInstance, IDI_BACKGROUND
	;----------------------------------------- 
	Ret
ClassApp_onStart endp