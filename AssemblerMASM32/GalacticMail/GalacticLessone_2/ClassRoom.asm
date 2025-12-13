ClassRoom_CreateRoom	proto :DWORD
;-------------------------------------------
ClassRoom_LoadBackgroud	proto :DWORD, :DWORD
;-------------------------------------------
ClassRoom_onLoop		proto
ClassRoom_onRender		proto
ClassRoom_onEvent		proto :DWORD
ClassRoom_onQuit		proto
ClassRoom_onKeyDown		proto :DWORD, :DWORD
ClassRoom_onExit		proto
;-------------------------------------------
ClassRoom_move_camera	proto :DWORD
ClassRoom_set_camera	proto :DWORD, :DWORD, :DWORD, :DWORD

.data
	background	dd 0
	camera		RECT <0, 0, ROOM_WIDTH, ROOM_HEIGHT>
	hSpeed		dd 0
	vSpeed		dd 0
	;---------------------------------------
	fRoomRender		dd offset ClassRoom_onRender
	fRoomLoop		dd offset ClassRoom_onLoop
	fRoomEvent		dd offset ClassRoom_onEvent
	fRoomQuit		dd offset ClassRoom_onQuit
	fRoomOnKeyDown	dd offset ClassRoom_onKeyDown

.code 
ClassRoom_CreateRoom proc uses ebx esi edi idRoom:DWORD
	switch idRoom
		case STATE_TITLE
			
		case STATE_ROOM_FIRST
			
		case STATE_ROOM_SECOND
			
		case STATE_ROOM_THIRD
			
		case STATE_ROOM_COMPLETED

	endsw
	Ret
ClassRoom_CreateRoom endp
;======================================================================
ClassRoom_onQuit proc uses ebx esi edi




	Ret
ClassRoom_onQuit endp
;======================================================================
ClassRoom_onEvent proc uses ebx esi edi idState:DWORD
	LOCAL dwReturnValue:DWORD
	;----------------------------------
	mov dword ptr[dwReturnValue], STATE_NULL
	;----------------------------------
	fn Keyboard_check
	;----------------------------------
	.if eax == VK_ESCAPE
		fn ClassRoom_onExit
		mov dword ptr[dwReturnValue], eax
	.else
		push idState
		push eax
		call dword ptr[fRoomOnKeyDown]
		;------------------------------
		mov dword ptr[dwReturnValue], eax
	.endif
	;----------------------------------
	mov eax, dword ptr[dwReturnValue]
	Ret
ClassRoom_onEvent endp
;======================================================================
ClassRoom_onLoop proc uses ebx esi edi
	



	Ret
ClassRoom_onLoop endp
;=====================================================================
ClassRoom_onRender proc uses ebx esi edi
	fn ClassIMG_DrawBMP, background, screen, camera.left, camera.top, camera.right, camera.bottom
	;-----------------------------------
	Ret
ClassRoom_onRender endp
;=====================================================================
ClassRoom_onKeyDown	proc uses ebx esi edi dwKey:DWORD, idState:DWORD
	LOCAL dwReturnValue:DWORD
	;------------------------------------
	mov dword ptr[dwReturnValue], STATE_NULL
	;------------------------------------
	mov eax, dword ptr[dwKey]
	or eax, eax
	je @@Ret
	;------------------------------------
	mov eax, dword ptr[idState]
	inc eax
	cmp eax, STATE_ROOM_COMPLETED
	;------------------------------------
	jg @F
	mov dword ptr[dwReturnValue], eax
	jmp @@Ret
	;------------------------------------
	@@:
		mov dword ptr[dwReturnValue], STATE_TITLE	
	;------------------------------------
	@@Ret:
		mov eax, dword ptr[dwReturnValue]
		Ret
ClassRoom_onKeyDown endp
;=====================================================================
ClassRoom_onExit proc 
	;-------------------
	mov eax, STATE_EXIT
	;-------------------
	Ret
ClassRoom_onExit endp
;=====================================================================
ClassRoom_LoadBackgroud proc uses ebx esi edi hInst:DWORD, idBmp:DWORD
	fn ClassIMG_LoadBMP, hInst, idBmp
	;---------------------------------
	mov dword ptr[background], eax
	;---------------------------------
	or eax, eax 
	jne @F
	;---------------------------------
	fn MessageBox, 0, "Load Backgroud failed.", "Error!", MB_ICONERROR
	fn ExitProcess, -1
	;---------------------------------
	@@:
		Ret
ClassRoom_LoadBackgroud endp
;========================================================================
ClassRoom_move_camera proc uses ebx esi edi lvlWidth:DWORD
	mov eax, dword ptr[hSpeed]
	add dword ptr[camera.left], eax
	;-------------------------------------
	mov eax, dword ptr[vSpeed]
	add dword ptr[camera.top], eax
	;-------------------------------------
	mov eax, dword ptr[camera.left]
	add eax, dword ptr[camera.right]
	cmp eax, lvlWidth
	jge @F
	jmp @@Ret
	;-------------------------------------
	@@:
		mov eax, dword ptr[lvlWidth]
		sub eax, dword ptr[camera.right]
		mov dword ptr[camera.left], eax
	;-------------------------------------
	@@Ret:
		Ret
ClassRoom_move_camera endp
;===========================================================================
ClassRoom_set_camera proc uses ebx esi edi left:DWORD, top:DWORD, right:DWORD, bottom:DWORD
	;---------------------------------------------------
	fn SetRect, offset camera, left, top, right, bottom
	;---------------------------------------------------
	Ret
ClassRoom_set_camera endp