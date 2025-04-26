
.code
simple_add proc uses ebx esi edi n1:DWORD, n2:DWORD
	mov eax, n1
	add eax, n2
	;----------------
	Ret
simple_add endp
;================================
int_add proc uses ebx esi edi n1:DWORD, n2:DWORD
	mov eax, n1
	add eax, n2
	;----------------
	jno @@Ret
	;---------------
	jns @F
	;---------------
	mov eax, 7FFFFFFFh
	jmp @@Ret
	;---------------
	@@:
		mov eax, 80000000h
	;---------------
	@@Ret:
		Ret
int_add endp