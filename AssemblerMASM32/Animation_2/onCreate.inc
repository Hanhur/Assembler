
.code
;EAX --> hWin
on_create proc
	mov ebx, eax
	;----------------
	fn GetClientRect, ebx, offset g_rc
	;----------------
	fn SetTimer, ebx, 1, FPS, 0
	;----------------
	Ret
on_create endp