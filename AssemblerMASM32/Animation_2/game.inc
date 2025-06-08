
.data
	g_rc	RECT <>
	
.code
game_update proc uses ebx esi edi
	mov ebx, eax
	;---------------
	lea esi, g_rc
	;----------------
	call player_move
	;----------------
	fn InvalidateRect, ebx, 0, 1
	;----------------
	Ret
game_update endp