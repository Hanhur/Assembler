ClassApp_updateState	proto

.code
ClassApp_updateState proc uses ebx esi edi
	.if next_state != STATE_NULL
		;call dword ptr[fRoomQuit]
		mov eax, lpvBase
		call dword ptr[eax + 12]
		;--------------------------------
		switch next_state
			case STATE_TITLE
				fn ClassRoom_CreateRoom, STATE_TITLE
			case STATE_ROOM_FIRST
				fn ClassRoom_CreateRoom, STATE_ROOM_FIRST
			case STATE_ROOM_SECOND
				fn ClassRoom_CreateRoom, STATE_ROOM_SECOND
			case STATE_ROOM_THIRD
				fn ClassRoom_CreateRoom, STATE_ROOM_THIRD
			case STATE_ROOM_COMPLETED
				fn ClassRoom_CreateRoom, STATE_ROOM_COMPLETED
		endsw
		;---------------------------------
		mov ebx, dword ptr[next_state]
		mov dword ptr[id_state], ebx
		;---------------------------------
		mov dword ptr[next_state], STATE_NULL
	.endif
	Ret
ClassApp_updateState endp