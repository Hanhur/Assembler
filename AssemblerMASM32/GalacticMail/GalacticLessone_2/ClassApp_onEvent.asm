ClassApp_onEvent	proto

.code
ClassApp_onEvent proc uses ebx esi edi
	push id_state
	;---------------------------------
	call dword ptr[fRoomEvent]
	;---------------------------------
	mov dword ptr[next_state], eax
	;---------------------------------
	Ret
ClassApp_onEvent endp