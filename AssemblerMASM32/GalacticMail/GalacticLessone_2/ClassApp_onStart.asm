ClassApp_onStart	proto

.code
ClassApp_onStart proc uses ebx esi edi
	mov dword ptr[id_state], STATE_ROOM_FIRST
	;-----------------------------------------
	fn ClassRoom_LoadBackgroud, hInstance, IDI_BACKGROUND
	;----------------------------------------- 
	;			Load Music
	;-----------------------------------------
	fn ClassRoom_CreateRoom, STATE_ROOM_FIRST
	;-----------------------------------------
	Ret
ClassApp_onStart endp