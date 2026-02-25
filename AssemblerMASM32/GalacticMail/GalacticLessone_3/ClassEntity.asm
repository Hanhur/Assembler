ClassEntity_Create		proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ClassEntity_onRender	proto :DWORD
;---------------------------- Private functions class Entity -----------------------
ClassEntity_LoadSprire		proto :DWORD, :DWORD
ClassEntity_GetCurrentFrame	proto :DWORD
ClassEntity_SetSprite		proto :DWORD, :DWORD, :DWORD, :DWORD
ClassEntity_SetCurrentFrame	proto :DWORD, :DWORD
ClassEntity_SetRandomFrame	proto :DWORD, :DWORD


SPRITE struct
	maxFrames		dd ?
	currentFrame	dd ? ;+4
	framaRate		dd ? ;+8
	oldTime			dd ? ;+12
	animate			db ? ;+16
SPRITE ends
;---------------------------------
ENTITY struct
				SPRITE <>
	id			dd ? ;+17
	sprite		dd ? ;+21
	x			dd ? ;+25
	y			dd ? ;+29
	w			dd ? ;+33
	h			dd ? ;+37
	speed		dd ? ;+41
	direction	dd ? ;+45
	rMask		RECT <>
	fLoop		dd ?
	fRender		dd ?
ENTITY ends
;---------------------------------
ID_NONE				= 0
MOON				= 1
BASE_MOON			= 2
ASTEROID			= 3
PLAYER				= 4
PLAYER_FLY			= 5
PLAYER_CRUSHED		= 6
PLAYER_COMPLETED	= 7
EXPLOSION			= 8
ID_TITLE			= 9
;----------------------------------
.const
	IDI_MOON	equ 101
	
	
.data
	pEntity		dd 0
	entity_num	dd 0

.code
ClassEntity_Create proc uses ebx esi edi id:DWORD, maxFrame:DWORD, rate:DWORD, wd:DWORD, ht:DWORD, x:DWORD, y:DWORD
	LOCAL pTemp:DWORD
	;-----------------------------------
	.if pEntity == 0
		fn LocalAlloc, LPTR, sizeof ENTITY
		mov dword ptr[pEntity], eax
	.else
		mov eax, sizeof ENTITY
		mov ebx, entity_num
		;-------------------------------
		inc ebx
		mul ebx
		;-------------------------------
		fn LocalAlloc, LPTR, eax
		mov dword ptr[pTemp], eax
		;-------------------------------
		mov eax, sizeof ENTITY
		mul entity_num
		;-------------------------------
		fn crt_memcpy, pTemp, pEntity, eax
		;-------------------------------
		fn LocalFree, pEntity
		;-------------------------------
		mov eax, dword ptr[pTemp]
		mov dword ptr[pEntity], eax
	.endif
	;-----------------------------------
	mov esi, pEntity
	mov eax, sizeof ENTITY
	mul entity_num
	add esi, eax
	;-----------------------------------
	assume esi:PTR ENTITY
	.if dword ptr[esi].sprite != 0
		mov eax, dword ptr[esi].sprite
		fn DeleteObject, eax
	.endif
	;-----------------------------------
	fn ClassEntity_SetSprite, esi, 0, maxFrame, rate
	;-----------------------------------
	mov eax, id
	mov dword ptr[esi].id, ebx
	;-----------------------------------
	.if ebx == MOON || ebx == BASE_MOON || ebx == ASTEROID
		mov dword ptr[esi].speed, 4
		;-------------------------------
		.if ebx == MOON || ebx == BASE_MOON
			fn ClassEntity_LoadSprire, hInstance, IDI_MOON
			;--------------------------
			mov dword ptr[esi].sprite, eax
			mov byte ptr[esi].animate, 0
			;--------------------------
			fn ClassEntity_SetRandomFrame, esi, maxFrame
		.elseif ebx == ASTEROID
		
		.endif
	.elseif ebx == PLAYER
	
	.elseif ebx == EXPLOSION
	
	.elseif ebx == ID_TITLE
	
	.endif
	;-----------------------------------
	mov dword ptr[esi].fRender, offset ClassEntity_onRender
	;-----------------------------------
	mov eax, wd
	mov dword ptr[esi].w, eax
	;-----------------------------------
	mov eax, ht
	mov dword ptr[esi].h, eax
	;-----------------------------------
	mov eax, x
	mov dword ptr[esi].x, eax
	;-----------------------------------
	mov eax, y
	mov dword ptr[esi].y, eax
	;-----------------------------------
	assume esi:nothing
	;-----------------------------------
	inc entity_num
	Ret
ClassEntity_Create endp
;====================================================================
ClassEntity_onRender proc uses ebx esi edi lpEntity:DWORD
	mov edi, lpEntity
	;--------------------------------------
	.if dword ptr[edi + 17] == ID_TITLE
		push 00FF4040h
	.else
		push 0FEFEFEh
	.endif
	;--------------------------------------
	push dword ptr[edi + 37]				;h
	push dword ptr[edi + 33]				;w
	push 0 ;y
	;--------------------------------------
	fn ClassEntity_GetCurrentFrame, lpEntity
	;--------------------------------------
	mov ebx, dword ptr[edi + 37]			;h
	mul ebx
	;--------------------------------------
	push eax								;x
	;--------------------------------------
	push dword ptr[edi + 37]				;h
	push dword ptr[edi + 33]				;w
	;--------------------------------------
	push dword ptr[edi + 29]				;y
	push dword ptr[edi + 25]				;x
	;--------------------------------------
	push screen
	push dword ptr[edi + 21]
	;--------------------------------------
	call ClassIMG_DrawTransparentBMP
	;--------------------------------------
	Ret
ClassEntity_onRender endp
;====================================================================
ClassEntity_LoadSprire proc uses ebx esi edi hInst:DWORD, idRes:DWORD
	fn LoadBitmap, hInst, idRes
	;---------------------------------------
	or eax, eax
	jne @@Ret
	;---------------------------------------
	fn MessageBox, 0, "Load Sprite Failed", "Error!", MB_ICONERROR
	fn ExitProcess, -1
	;---------------------------------------
	@@Ret:
		Ret
ClassEntity_LoadSprire endp
;===============================================================
ClassEntity_GetCurrentFrame proc uses ebx esi edi lpEntity:DWORD
	mov eax, lpEntity
	mov eax, dword ptr[eax + 4]
	;---------------------------------------------
	Ret
ClassEntity_GetCurrentFrame endp
;===============================================================
ClassEntity_SetSprite proc uses ebx esi edi lpEntity:DWORD, curFrame:DWORD, maxFrame:DWORD, rate:DWORD
	mov edi, lpEntity
	;--------------------------------------
	mov eax, curFrame
	mov dword ptr[edi + 4], eax
	;--------------------------------------
	mov eax, maxFrame
	mov dword ptr[edi], eax
	;--------------------------------------
	mov eax, rate
	mov dword ptr[edi + 8], eax
	;--------------------------------------
	fn GetTickCount
	;--------------------------------------
	mov dword ptr[edi + 12], eax
	;--------------------------------------
	mov byte ptr[edi + 16], 1
	;--------------------------------------
	Ret
ClassEntity_SetSprite endp
;============================================================================
ClassEntity_SetCurrentFrame proc uses ebx esi edi lpEntity:DWORD, frame:DWORD
	mov edi, lpEntity
	;----------------------------
	mov ebx, frame
	mov dword ptr[edi + 4], ebx
	;----------------------------
	Ret
ClassEntity_SetCurrentFrame endp
;============================================================================
ClassEntity_SetRandomFrame proc uses ebx esi edi lpEntity:DWORD, rmax:DWORD
	mov edi, lpEntity
	;---------------------------
	fn RangedRand, 1, rmax
	;---------------------------
	dec eax
	mov dword ptr[edi + 4], eax
	;---------------------------
	Ret
ClassEntity_SetRandomFrame endp
