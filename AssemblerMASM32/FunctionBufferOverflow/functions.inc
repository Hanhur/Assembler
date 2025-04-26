include \masm32\include\advapi32.inc
includelib \masm32\lib\advapi32.lib
;====================================

.code
get_comp_info proc
	LOCAL nsize:DWORD
	LOCAL comp_name[256]:BYTE
	;-------------------------
	push ebx
	push esi
	push edi
	;-------------------------
	lea ebx, nsize
	lea esi, comp_name
	;-------------------------
	mov dword ptr[ebx], 256
	;-------------------------
	push ebx
	push esi
	;------------------------
	call GetComputerName
	;------------------------
	mov eax, dword ptr[ebx]
	mov byte ptr[esi + eax], 5Ch
	;------------------------
	lea edi, dword ptr[esi + eax + 1]
	;------------------------
	mov eax, 256
	sub edx, eax
	dec edx
	;------------------------
	mov dword ptr[ebx], edx
	;------------------------
	push ebx
	push edi
	;-----------------------
	call GetUserName
	;-----------------------
	printf("Computer Info: %s\n\n", esi)
	;-----------------------
	pop edi
	pop esi
	pop ebx
	;-----------------------
	Ret
get_comp_info endp