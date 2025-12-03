
ClassRoom_LoadBackgroud	proto :DWORD, :DWORD

.data
	background	dd 0

.code 
ClassRoom_LoadBackgroud proc uses ebx esi edi hInst:DWORD, idBmp:DWORD
	fn ClassIMG_LoadBMP, hInst, idBmp
	;---------------------------------
	mov dword ptr[background], eax
	;---------------------------------
	or eax, eax 
	jne @F
	;---------------------------------
	fn MessageBox, 0, "Load Backgroud failed.", "Error!", MB_ICONERROR
	fn ExitProcess, -1
	;---------------------------------
	@@:
		Ret
ClassRoom_LoadBackgroud endp