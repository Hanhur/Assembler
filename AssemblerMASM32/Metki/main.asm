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
	;jna @@L0 ;esli znacheniya nebolshe
	;jb @@L0 ;esli znacheniya nizhe
	;jl @@L0 ;jump if less -> esli znacheniya menshe
	jg @@L0 ;jump if grate -> esli znacheniya bolshe, dlya otricatelnych cisel
	;-----------------
	jmp @@Ret
@@L0:
	nop
	xor ebx, ebx
	;-----------------
@@For:
	inc ebx
	cmp ebx, ecx ;cmp sravnenie
	jl @@For
	;-----------------
@@Ret:
	inkey
	xor eax, eax
	Ret
main endp
end start