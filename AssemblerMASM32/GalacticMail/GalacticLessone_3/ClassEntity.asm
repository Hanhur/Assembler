ClassEntity_Create	proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD



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
	assume esi:nothing
	;-----------------------------------
	inc entity_num
	Ret
ClassEntity_Create endp