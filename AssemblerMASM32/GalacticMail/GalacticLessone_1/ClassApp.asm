include ClassTimer.asm
;---------------------------------
ClassApp_onExecute	proto


.const
	STATE_NULL				equ 0
	STATE_TITLE				equ 1
	STATE_ROOM_FIRST		equ 2
	STATE_ROOM_SECOND		equ 3
	STATE_ROOM_THIRD		equ 4
	STATE_ROOM_COMPLETED	equ 5
	STATE_EXIT				equ 6


.data
	id_state	dd STATE_NULL
	next_state	dd STATE_NULL
	;--------------------------
	include ClassApp_onInit.asm
	include ClassApp_onStart.asm
	include ClassApp_onQuit.asm
	include ClassApp_onLoop.asm
	include ClassApp_onRender.asm
	include ClassApp_onEvent.asm
	include ClassApp_updateState.asm
	include ClassApp_onGame.asm


.code
;================= ClassApp_onExecute ================
ClassApp_onExecute proc uses ebx esi edi
	LOCAL dwReturnValue:DWORD
	;------------------------------------
	mov dword ptr[dwReturnValue], STATE_NULL
	;------------------------------------
	fn ClassApp_onInit
	;------------------------------------
	or eax, eax
	jne @F ;esli ne 0 my dvizemsa v perod
	;------------------------------------
	fn MessageBox, 0, "Game Initialize failed!", "Error!", MB_ICONERROR
	;------------------------------------
	xor eax, eax
	dec eax
	mov dword ptr[dwReturnValue], eax
	jmp @@Ret
	;------------------------------------
	@@:
		fn ClassApp_onStart
		;--------------------------------
		;			GAME LOOP
		;--------------------------------
		fn ClassApp_onGame
		;--------------------------------
		fn ClassApp_onQuit
	;------------------------------------
	@@Ret:
		mov eax, dword ptr[dwReturnValue]
		Ret
ClassApp_onExecute endp