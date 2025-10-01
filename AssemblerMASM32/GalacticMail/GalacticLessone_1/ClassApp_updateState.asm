ClassApp_updateState	proto


.code
;====================== ClassApp_updateState ==========================
ClassApp_updateState proc uses ebx esi edi
	.if next_state != STATE_NULL
		switch next_state
			case STATE_TITLE
			
			case STATE_ROOM_FIRST
			
			case STATE_ROOM_SECOND
			
			case STATE_ROOM_THIRD
			
			case STATE_ROOM_COMPLETED
			
		endsw
		;------------------------------------
		mov ebx, dword ptr[next_state]
		mov dword ptr[id_state], ebx
		;------------------------------------
		mov dword ptr[next_state], STATE_NULL
	.endif
	Ret
ClassApp_updateState endp