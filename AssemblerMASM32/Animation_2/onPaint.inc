
.code
;EAX --> hWin
on_paint proc
	LOCAL ps:PAINTSTRUCT
	;--------------------
	mov ebx, eax ;sochranyajem deskriptor akoshka
	;--------------------
	lea esi, ps
	;--------------------
	fn BeginPaint, eax, esi
	;--------------------
	fn draw_player, eax
	;-------------------


	;--------------------
	fn EndPaint, ebx, esi
	;--------------------
	Ret
on_paint endp