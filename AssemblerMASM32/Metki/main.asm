include main.inc

.code
start:
	call main
	;--------------
	push eax
	;--------------
	call ExitProcess 
;=====================
main proc
	mov eax, 10
	mov edx, 20
	;-----------------
	;cmp eax, edx
	;sub eax, edx
	;je @@L0 ;jump if equa -> esli znacheniya ravny
	;------------------
	cmp eax, edx
	;jne ;esli znacheniya neravny
	;ja @@L0 ;jump if above -> esli znacheniya bolshe
	jna @@L0 ;esli znacheniya nebolshe
	;-----------------
	jmp @@Ret
@@L0:
	nop
	nop
	
	
	;-----------------
@@Ret:
	inkey
	xor eax, eax
	Ret
main endp
end start