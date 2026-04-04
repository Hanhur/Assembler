include \masm32\include\masm32rt.inc

ARRAY_COUNT = 8

sum_two_smallest_numbers		proto :DWORD, :DWORD
bad_sum_two_smallest_numbers	proto :DWORD, :DWORD

.data
	array	dd 19, 3, 59, 48, 10, 5, 24, 15
	
.code
;===============================================================================
bad_sum_two_smallest_numbers proc uses ebx esi edi array_int:DWORD, count:DWORD
	fn nrQsortA, array_int, count
	;-----------------------------
	push array_int
	pop eax
	;----------------------------
	push dword ptr[eax + 4]
	push dword ptr[eax]
	pop eax
	pop edx
	add eax, edx
	;----------------------------
	Ret
bad_sum_two_smallest_numbers endp
;===========================================================================
sum_two_smallest_numbers proc uses ebx esi edi array_int:DWORD, count:DWORD
	LOCAL low_one:DWORD
	LOCAL low_two:DWORD
	;-----------------------------
	mov low_one, 7FFFFFFFh
	mov low_one, 7FFFFFFFh
	;-----------------------------
	push array_int
	pop esi
	;-----------------------------
	xor ebx, ebx
	jmp @@For
	;-----------------------------
	@@In:
	;-----------------------------
	; if(array[i] < low_one)
	;-----------------------------
		mov eax, dword ptr[esi + ebx * 4]
		mov edx, low_one
		cmp eax, edx
		jge @F
	;-----------------------------
	; low_two = low_one
	; low_one = array[i]
	;-----------------------------
		push eax
		push low_one
		pop low_two
		pop low_one
	;-----------------------------
		jmp @@Next
	;-----------------------------
	@@:
		mov edx, low_two
		cmp eax, edx
		jge @@Next
	;-----------------------------
	; if(array[i] < low_two
	; low_two = array[i]
	;-----------------------------
		push eax
		pop low_two
	;-----------------------------
	@@Next:
		inc ebx
	;-----------------------------
	@@For:
		cmp ebx, count
		jl @@In
		;-------------------------
		push low_two
		push low_one
		pop eax
		pop edx
		add eax, edx
	;-----------------------------
	Ret
sum_two_smallest_numbers endp