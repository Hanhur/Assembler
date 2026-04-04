ClassIMG_LoadBMP			proto :DWORD, :DWORD
ClassIMG_DrawBMP			proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ClassIMG_DrawTransparentBMP	proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

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
;=================================================================
ClassIMG_DrawTransparentBMP proc uses ebx esi edi hBmp:DWORD, hScreen:DWORD, x1:DWORD, y1:DWORD, w1:DWORD, h1:DWORD, x2:DWORD, y2:DWORD, w2:DWORD, h2:DWORD, color:DWORD
	LOCAL hOldBmp:DWORD
	LOCAL hMemDC:DWORD
	;-----------------------------------
	fn CreateCompatibleDC, hScreen
	;-----------------------------------
	mov dword ptr[hMemDC], eax
	;-----------------------------------
	fn SelectObject, eax, hBmp
	mov dword ptr[hOldBmp], eax
	;-----------------------------------
	fn TransparentBlt, hScreen, x1, y1, w1, h1, hMemDC, x2, y2, w2, h2, color
	;-----------------------------------
	fn SelectObject, hMemDC, hOldBmp
	fn DeleteDC, hMemDC
	;-----------------------------------
	Ret
ClassIMG_DrawTransparentBMP endp