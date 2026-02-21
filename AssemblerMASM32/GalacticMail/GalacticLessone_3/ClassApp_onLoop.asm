ClassApp_onLoop		proto

.code
ClassApp_onLoop proc uses ebx esi edi
	;call dword ptr[fRoomLoop]
	mov eax, lpvBase
	call dword ptr[eax + 4]
	;----------------------------------
	Ret
ClassApp_onLoop endp