ClassEntity_Create		proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ClassEntity_onRender	proto :DWORD
ClassEntity_onLoop		proto :DWORD
;---------------------------- Private functions class Entity -----------------------
ClassEntity_LoadSprire		proto :DWORD, :DWORD
ClassEntity_GetCurrentFrame	proto :DWORD
ClassEntity_SetSprite		proto :DWORD, :DWORD, :DWORD, :DWORD
ClassEntity_SetCurrentFrame	proto :DWORD, :DWORD
ClassEntity_SetRandomFrame	proto :DWORD, :DWORD
ClassEntity_onAnimate		proto :DWORD
ClassEntity_onAnimationEnd	proto :DWORD
ClassEntity_onMove			proto :DWORD
ClassEntity_outsideRoom		proto :DWORD, :DWORD, :DWORD
ClassEntity_wrap			proto :DWORD, :DWORD, :DWORD
;---------------------------- Functions Class Moon ----------------------------------
ClassMoon_onLoop			proto :DWORD


MemSet						proto :DWORD, :DWORD, :DWORD


SPRITE struct
	maxFrames		dd ?
	currentFrame	dd ? ;+4
	frameRate		dd ? ;+8
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
	Reserv		db 3 dup(?)
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
	IDI_MOON		equ 101
	IDI_ASTEROID	equ 102
	
	
.data
	pEntity		dd 0
	entity_num	dd 0
	PI			REAL8 3.14159265r
	Degree		REAL8 180.0r

.code
MemSet proc uses ebx esi edi pDest:DWORD, pSrc:DWORD, dwSize:DWORD
	mov edi, pDest
	mov esi, pSrc
	mov ecx, dwSize
	shr ecx, 2
	;-------------------------
	@@Loop:
		lodsd
		stosd
		
		loop @@Loop
	;--------------------------
	Ret
MemSet endp
;===================================================================================================================
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
		;fn crt_memcpy, pTemp, pEntity, eax
		fn MemSet, pTemp, pEntity, eax
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
			fn ClassEntity_LoadSprire, hInstance, IDI_ASTEROID
			;--------------------------
			mov dword ptr[esi].sprite, eax
		.endif
		;--------------------------------
		fn RangedRand, 1, 361
		dec eax 
		mov dword ptr[esi].direction, eax
		;--------------------------------
		mov dword ptr[esi].fLoop, offset ClassMoon_onLoop
		;--------------------------------
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
ClassEntity_onLoop proc uses ebx esi edi lpEntity:DWORD
	fn ClassEntity_onAnimate, lpEntity

	Ret
ClassEntity_onLoop endp
;====================================================================
ClassMoon_onLoop proc uses ebx esi edi lpEntity:DWORD
	fn ClassEntity_onLoop, lpEntity
	;---------------------------------
	fn ClassEntity_onMove, lpEntity
	;---------------------------------
	fn ClassEntity_outsideRoom, lpEntity, ROOM_WIDTH, ROOM_HEIGHT
	;---------------------------------
	or eax, eax
	je @@Ret
	;---------------------------------
	fn ClassEntity_wrap, lpEntity, ROOM_WIDTH, ROOM_HEIGHT
	;---------------------------------
	@@Ret:
		Ret
ClassMoon_onLoop endp
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
;=============================================================================
ClassEntity_onAnimate proc uses ebx esi edi lpEntity:DWORD
	mov edi, lpEntity
	;--------------------------------------
	cmp byte ptr[edi + 16], 0
	je @@Ret
	;--------------------------------------
	;if(oldTime + frameRate > GetTickCount)
	;	return
	fn GetTickCount
	;--------------------------------------
	mov ebx, dword ptr[edi + 12] ; oldTime
	add ebx, dword ptr[edi + 8] ; frameRate
	cmp ebx, eax
	jg @@Ret
	;--------------------------------------
	mov dword ptr[edi + 12], eax
	;--------------------------------------
	inc dword ptr[edi + 4]	; currentFrame
	;--------------------------------------
	mov eax, dword ptr[edi + 4]
	cmp eax, dword ptr[edi]
	jl @F
	;--------------------------------------
	mov dword ptr[edi + 4], 0
	;-------------------------------------
	@@:
		mov eax, dword ptr[edi + 4]
		mov ebx, dword ptr[edi]
		dec ebx
		cmp eax, ebx
		jne @@Ret
		;---------------------------------
		fn ClassEntity_onAnimationEnd, edi
	;-------------------------------------
	@@Ret:
		Ret
ClassEntity_onAnimate endp
;==============================================================
ClassEntity_onAnimationEnd proc uses ebx esi edi lpEntity:DWORD
	mov edi, lpEntity
	;--------------------------------
	.if dword ptr[edi + 17] == EXPLOSION
		mov byte ptr[edi + 16], 0
	.endif
	;-------------------------------
	Ret
ClassEntity_onAnimationEnd endp
;================================================================
ClassEntity_onMove proc uses ebx esi edi lpEntity:DWORD
	LOCAL x_offset:DWORD
	LOCAL y_offset:DWORD
	LOCAL angle:REAL8
	;------------------------------------
	; Degree to Rad = angel * PI / 180
	;------------------------------------
	mov dword ptr[x_offset], 0
	mov dword ptr[y_offset], 0
	mov edi, lpEntity
	assume edi:PTR ENTITY
	;------------------------------------
	fld qword ptr[PI]
	fld qword ptr[Degree]
	;------------------------------------
	fdivp st(1), st
	;------------------------------------
	fild dword ptr[edi].direction
	fmulp st(1), st
	;------------------------------------
	fstp qword ptr[angle]
	;------------------------------------
	; x_offset = speed * cos(angle)
	;------------------------------------
	fld qword ptr[angle]
	fcos
	fild dword ptr[edi].speed
	;------------------------------------
	fmulp st(1), st
	;------------------------------------
	fistp dword ptr[x_offset]
	;------------------------------------
	; y_offset = speed * sin(angle)
	;------------------------------------
	fld qword ptr[angle]
	fsin
	;------------------------------------
	fild dword ptr[edi].speed
	fmulp st(1), st
	;------------------------------------
	fistp dword ptr[y_offset]
	;------------------------------------
	mov eax, dword ptr[x_offset]
	add dword ptr[edi].x, eax
	;------------------------------------
	mov eax, dword ptr[y_offset]
	sub dword ptr[edi].y, eax
	;------------------------------------
	assume edi:nothing
	Ret
ClassEntity_onMove endp
;================================================================================
ClassEntity_outsideRoom proc uses ebx esi edi lpEntity:DWORD, rw:DWORD, rh:DWORD
	LOCAL result:DWORD
	;----------------------------
	mov dword ptr[result], 0
	;----------------------------
	mov edi, lpEntity
	assume edi:PTR ENTITY
	;----------------------------
	; if(y + h < 0 || y > height)
	;----------------------------
	mov eax, dword ptr[edi].y
	add eax, dword ptr[edi].h
	;----------------------------
	cmp eax, 0
	jl @@True
	;----------------------------
	mov eax, dword ptr[edi].y
	cmp eax, dword ptr[rh]
	jg @@True
	;----------------------------
	; if(x + w < 0 || x > width)
	;----------------------------
	mov eax, dword ptr[edi].x
	add eax, dword ptr[edi].w
	cmp eax, 0
	jl @@True
	;----------------------------
	mov eax, dword ptr[edi].x
	cmp eax, dword ptr[rw]
	jle @@Ret
	;---------------------------
	@@True:
		mov dword ptr[result], 1
	;---------------------------
	@@Ret:
		assume edi:nothing
		mov eax, dword ptr[result]
		Ret
ClassEntity_outsideRoom endp
;========================================================================
ClassEntity_wrap proc uses ebx esi edi lpEntity:DWORD, rw:DWORD, rh:DWORD
	mov edi, lpEntity
	assume edi:PTR ENTITY
	;---------------------------------
	; if(x + w < 0) x = room_width
	; if(x > room_width) x = -w
	;---------------------------------
	mov eax, dword ptr[edi].x
	add eax, dword ptr[edi].w
	cmp eax, 0
	jge @F
	;---------------------------------
	mov eax, dword ptr[rw]
	mov dword ptr[edi].x, eax
	;---------------------------------
	@@:
		mov eax, dword ptr[edi].x
		cmp eax, dword ptr[rw]
		jle @F
		;-----------------------------
		mov eax, dword ptr[edi].w
		neg eax
		mov dword ptr[edi].x, eax
	;---------------------------------
	; if( y + h < 0) y = room_height
	; if(y > room_height) y = -h
	;---------------------------------
	@@:
		mov eax, dword ptr[edi].y
		add eax, dword ptr[edi].h
		cmp eax, 0
		jge @F
		;----------------------------
		mov eax, dword ptr[rh]
		mov dword ptr[edi].y, eax
	;---------------------------------
	@@:
		mov eax, dword ptr[edi].y
		cmp eax, dword ptr[rh]
		jle @F
		;-----------------------------
		mov eax, dword ptr[edi].h
		neg eax
		mov dword ptr[edi].y, eax
	;---------------------------------
	@@:
		assume edi:nothing
		Ret
ClassEntity_wrap endp
