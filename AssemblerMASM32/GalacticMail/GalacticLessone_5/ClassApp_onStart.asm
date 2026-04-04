ClassApp_onStart	proto

.code
ClassApp_onStart proc uses ebx esi edi
	LOCAL sTimeCaps:TIMECAPS
	;-----------------------------------------
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
	fn timeGetDevCaps, addr sTimeCaps, sizeof TIMECAPS
	;-----------------------------------------
	mov eax, sTimeCaps.wPeriodMin
	mov dword ptr[minResolution], eax
	;----------------------------------------
	fn timeBeginPeriod, eax
	;----------------------------------------
	;fn timeSetEvent, 40, minResolution, offset ClassApp_GameController, 0, 1
	mov dword ptr[id_timer], eax
	;----------------------------------------
	Ret
ClassApp_onStart endp