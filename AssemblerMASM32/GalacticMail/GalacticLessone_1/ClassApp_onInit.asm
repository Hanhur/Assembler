ClassApp_onInit		proto

.code
;====================== ClassApp_onInit =====================
ClassApp_onInit proc uses ebx esi edi
	LOCAL dwReturnValue:DWORD
	;---------------------------------
	mov dword ptr[dwReturnValue], 1
	;---------------------------------
	fn SetConsoleTitle, "Galactic Mail v1.0"
	;---------------------------------
	fn SetConsoleCoursor, 0
	;---------------------------------

	;---------------------------------
	mov eax, dword ptr[dwReturnValue]
	Ret
ClassApp_onInit endp