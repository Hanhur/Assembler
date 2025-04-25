.code
addNumbers proc
	; Prolog function
	push ebp
	mov ebp, esp
	;-------------------
	push ebx
	push esi
	push edi
	;-------------------
	; Telo function
	mov eax, dword ptr[ebp + 8]
	add eax, dword ptr[ebp + 0Ch]
	;-------------------
	; Epilog function
	pop edi
	pop esi
	pop ebx
	;-------------------
	mov esp, ebp
	pop ebp
	;-------------------
	Ret 8
addNumbers endp	
;==================================
calculate proc
	push ebp
	mov ebp, esp
	;-------------------
	push ebx
	push esi
	push edi
	;-------------------
	; Telo function
	mov eax, dword ptr[ebp + 8]
	imul eax, eax ;umnochenie
	;-------------------
	mov eax, dword ptr[ebp + 0Ch]
	imul edx, edx
	;-------------------
	call _add
	;-------------------
	; Epilog function
	pop edi
	pop esi
	pop ebx
	;-------------------
	mov esp, ebp
	pop ebp
	;-------------------
	Ret 8
calculate endp
;==================================
_add proc
	add eax, edx
	Ret
_add endp