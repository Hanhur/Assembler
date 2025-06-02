;===============================================
;       Console Functions by Tempesta 2024
;===============================================



;===============================================
;           Functions prototypes
;===============================================

console_init              proto :DWORD,:DWORD,:DWORD    
set_console_cursor        proto :DWORD
set_console_color         proto :DWORD,:DWORD
set_console_center_screen proto

set_text_color            proto :DWORD,:DWORD

;===============================================
;    Background and foreground colors
;===============================================

  cBlack        = 0
  cBlue         = 1
  cGreen        = 2
  cCyan         = 3
  cRed          = 4
  cMagenta      = 5
  cBrown        = 6
  cLightGray    = 7
  cDarkGray     = 8
  cLightBlue    = 9
  cLightGreen   = 10
  cLightCyan    = 11
  cLightRed     = 12
  cLightMagenta = 13
  cLightYellow  = 14
  cWhite        = 15


putchars MACRO char:VARARG

    FOR arg,<char>
    
     fn crt_putchar,arg
     
    ENDM
endm
;====================================================
.data
szBlack        db "Black",0
szBlue         db "Blue",0
szGreen        db "Green",0
szCyan         db "Cyan",0
szRed          db "Red",0
szMagenta      db "Magenta",0
szBrown        db "Brown",0
szLightGray    db "LightGray",0
szDarkGray     db "DarkGray",0
szLightBlue    db "LightBlue",0
szLightGreen   db "LightGreen",0
szLightCyan    db "LightCyan",0
szLightRed     db "LightRed",0
szLightMagenta db "LightMagenta",0
szLightYellow  db "LightYellow",0
szBrightWhite  db "BrightWhite",0
;-------------------------------
colors        dd offset szBlack
              dd offset szBlue
              dd offset szGreen
              dd offset szCyan
              dd offset szRed
              dd offset szMagenta
              dd offset szBrown
              dd offset szLightGray
              dd offset szDarkGray
              dd offset szLightBlue
              dd offset szLightGreen
              dd offset szLightCyan
              dd offset szLightRed
              dd offset szLightMagenta
              dd offset szLightYellow
              dd offset szBrightWhite

.code
;====================================================
console_init proc uses ebx esi edi nCol:DWORD,nLines:DWORD,lpszTitle:DWORD
    LOCAL buffer[28]:BYTE
    
    lea esi,buffer
    ;-------------
    fn wsprintf,esi,CADD("mode con:cols=%d lines=%d"),nCol,nLines
    ;-------------
    fn crt_system,esi
    ;-------------
    fn SetConsoleTitle,lpszTitle

	ret
console_init endp
;====================================================
set_console_center_screen proc uses ebx esi edi
   LOCAL rc:RECT
   
   lea ebx,rc
   ;----------------
   fn GetConsoleWindow
   ;----------------
   mov edi,eax
   ;----------------
   fn GetWindowRect,eax,ebx
   ;----------------
   push SWP_NOSIZE
   push 0
   push 0
   ;----------------
   fn GetSystemMetrics,1
   ;----------------
   mov edx,dword ptr[ebx+0Ch]
   sub edx,dword ptr[ebx+4]
   sub eax,edx
   shr eax,1
   push eax
   ;----------------
   fn GetSystemMetrics,0
   ;----------------
   mov edx,dword ptr[ebx+8]
   sub edx,dword ptr[ebx]
   sub eax,edx
   shr eax,1
   push eax
   push 0
   push edi
   ;----------------
   call SetWindowPos

	ret
set_console_center_screen endp
;====================================================
set_console_cursor proc uses ebx esi edi bVisible:DWORD
    LOCAL ci:CONSOLE_CURSOR_INFO
    
	lea ebx,ci
	;---------------------------
	fn GetStdHandle,-11
	;---------------------------
	mov edi,eax
	;---------------------------
	fn GetConsoleCursorInfo,eax,ebx
    ;---------------------------
    mov eax,bVisible
    ;---------------------------
    mov (CONSOLE_CURSOR_INFO ptr[ebx]).bVisible,eax
	;---------------------------
    fn SetConsoleCursorInfo,edi,ebx
    
	ret
set_console_cursor endp
;====================================================
set_console_color proc uses ebx esi edi cfrg:DWORD,cbkg:DWORD

    mov ebx,cbkg
	shl bl,4
	;--------------
	mov eax,cfrg
	;--------------
	or bl,al
    ;--------------
    fn SetConsoleTextAttribute,rv(GetStdHandle,-11),ebx

	ret
set_console_color endp
;=====================================================
set_text_color proc uses ebx esi edi lpszForegroundColor:DWORD,lpszBackgroundColor:DWORD
    LOCAL lens:DWORD
    
    xor eax,eax
	or ecx,0FFFFFFFFh
    mov edi,lpszForegroundColor
    repne scasb
    not ecx
    dec ecx
    mov lens,ecx
    
    ;------------
    xor ebx,ebx
@@For:
    mov edi,lpszForegroundColor
    lea esi,colors
    mov esi,dword ptr[esi+ebx*4]
    ;-------------
    mov ecx,lens
    repe cmpsb
    je @@Next
    ;-------------
    inc ebx
    cmp ebx,10h
    jl @@For
    ;--------------
@@Next:
    xor edx,edx
    mov edi,lpszBackgroundColor
    or edi,edi
    je @@Ret
    ;--------------
    xor eax,eax
	or ecx,0FFFFFFFFh
    mov edi,lpszBackgroundColor
    repne scasb
    not ecx
    dec ecx
    mov lens,ecx
    ;--------------
@@For2:
    mov edi,lpszBackgroundColor
    lea esi,colors
    mov esi,dword ptr[esi+edx*4]
    ;-------------
    mov ecx,lens
    repe cmpsb
    je @@Ret
    ;-------------
    inc edx
    cmp edx,10h
    jl @@For2
    ;--------------

@@Ret:
    fn set_console_color,ebx,edx
	ret
set_text_color endp
;=====================================================