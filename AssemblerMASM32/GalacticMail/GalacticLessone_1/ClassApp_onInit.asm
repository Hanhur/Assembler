ClassApp_onInit		proto

.code
ClassApp_onInit proc uses ebx esi edi
	LOCAL dwReturnValue:DWORD
	;---------------------------------
	mov dword ptr[dwReturnValue], 1
	;---------------------------------


	;---------------------------------
	mov eax, dword ptr[dwReturnValue]
	Ret
ClassApp_onInit endp