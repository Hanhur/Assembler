ClassApp_onLoop		proto

.code
ClassApp_onLoop proc uses ebx esi edi
	call dword ptr[fRoomLoop]
	;----------------------------------
	Ret
ClassApp_onLoop endp