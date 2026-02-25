ClassApp_onStart	proto

.code
ClassApp_onStart proc uses ebx esi edi
	fn crt_time, 0
	fn crt_rand, eax
	;-----------------------------------------
	mov dword ptr[id_state], STATE_ROOM_FIRST
	;-----------------------------------------
	fn ClassRoom_LoadBackground, hInstance, IDI_BACKGROUND
	fn ClassRoom_VirtualAlloc
	;----------------------------------------- 
	;			Load Music
	;-----------------------------------------
	fn ClassRoom_CreateRoom, STATE_ROOM_FIRST
	;-----------------------------------------
	Ret
ClassApp_onStart endp