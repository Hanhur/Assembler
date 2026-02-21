ClassIMG_LoadBMP	proto :DWORD, :DWORD
ClassIMG_DrawBMP	proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

.code 
ClassIMG_LoadBMP proc uses ebx esi edi hInst:DWORD, idBmp:DWORD
	fn LoadBitmap, hInst, idBmp
	;---------------------------------
	Ret
ClassIMG_LoadBMP endp
;================================================================
ClassIMG_DrawBMP proc uses ebx esi edi hBitmap:DWORD, hScreen:DWORD, x:DWORD, y:DWORD, w:DWORD, h:DWORD
	LOCAL hOldBmp:DWORD
	LOCAL hMemDC:DWORD
	;-----------------------------------
	fn CreateCompatibleDC, hScreen
	;-----------------------------------
	mov dword ptr[hMemDC], eax
	;-----------------------------------
	fn SelectObject, eax, hBitmap
	mov dword ptr[hOldBmp], eax
	;-----------------------------------
	fn BitBlt, hScreen, x, y, w, h, hMemDC, 0, 0, 00CC0020h ;SRCCOPY
	;-----------------------------------
	fn SelectObject, hMemDC, hOldBmp
	fn DeleteDC, hMemDC
	;-----------------------------------
	Ret
ClassIMG_DrawBMP endp