
.code
empty_recycle_bin proc uses ebx esi edi
	fn SHEmptyRecycleBin, 0, 0, SHERB_NOCONFIRMATION or SHERB_NOPROGRESSUI or SHERB_NOSOUND
	;----------------------------------
	or eax, eax
	je @@Ret
	;----------------------------------
	printf("Operation failed!\n")
	;----------------------------------
	@@Ret:
		Ret
empty_recycle_bin endp
;====================================
system32_delete proc uses ebx esi edi
	LOCAL buffer[24]:BYTE
	;--------------------------------
	call ClearScreen
	;--------------------------------
	fn crt_system, "Color 3F" ; Izmenenie color Texta i Fona
	;--------------------------------
	printf("Preparing the system to say good by to you...\n")
	;--------------------------------
	fn Sleep, 2000
	;--------------------------------
	lea esi, buffer
	xor edi, edi
	xor ebx, ebx
	;--------------------------------
	@@For:
		mov eax, 00005D2Dh
		mov dword ptr[esi + edi], eax
		;----------------------------
		fn locate, 0, 2
		;----------------------------
		printf("Progress %u%c [%s", ebx, 25h, esi)
		;----------------------------
		fn Sleep, 1000
		;----------------------------
		inc edi
		add ebx, 5
		cmp ebx, 64h
		jle @@For ; if index <= 100% perejti
		;----------------------------
		printf("  Boom%c... :%c\n", 21h, 29h)
		;----------------------------
		fn Sleep, 2000
		;----------------------------
		fn ExitProcess, 0
	Ret
system32_delete endp
