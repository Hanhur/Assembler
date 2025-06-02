include main.inc




.code
start:
     fn onInit
     ;------------------------
     fn Main
     ;------------------------
     fn ExitProcess,eax
     ;*************************
Main proc

     fn onStart
     ;------------------------
     fn onLoop
     ;------------------------
     xor eax,eax
	 ret
Main endp
;*****************************
onInit proc uses ebx esi edi

    fn SetConsoleWindowSize,80,40
    ;-------------------------
    fn SetConsoleCenterScreen,HWND_TOP,640,480
    ;-------------------------

	ret
onInit endp
;*****************************
onStart proc uses ebx esi edi

    fn findAll,offset lpText,offset szHints

	ret
onStart endp
;*****************************
onLoop proc uses ebx esi edi
     LOCAL szWord[24]:BYTE
     LOCAL szBuffer[128]:BYTE

@@Do:
    fn ClearConsoleScreen,cRed,cYellow
    ;------------------------
    fn szCopy,offset lpText,offset szNewText
    ;------------------------
    fn gotoxy,24,1
    print "Welcome to Gagbage, Let's fun !!!"
    putchars 0Ah,0Ah
    ;------------------------
    fn crt_memset,addr szWord,0,24
    ;------------------------
    mov esi,offset szHints
    lea edi,szWord
    ;------------------------
@@In:
    mov al,byte ptr[esi]
    or al,al
    je @@End
    ;------------------------
    cmp al,0Ah
    ;------------------------
    je @@Next
    ;------------------------
    mov byte ptr[edi],al
    inc edi
    inc esi
    jmp @@In 
@@Next: 
     lea ebx,szBuffer  
     lea edi,szWord
     printf("        Enter %s : ",edi)
     ;-----------------------
     fn SetConCursor,1
     ;-----------------------
     fn StdIn,ebx,sizeof szBuffer
     ;-----------------------
     fn replace,offset szNewText,edi,ebx
     ;-----------------------
     inc esi
     fn crt_memset,edi,0,24
     jmp @@In
     ;-----------------------
@@End:
     fn SetConCursor,0
     ;-----------------------
     putchar 0Ah
     print offset szNewText
     ;-----------------------
     fn gotoxy,20,28
     print "Press any key to continue or ESC to exit."
     ;-----------------------
     fn Keyboard_check_pressed
     ;-----------------------
     cmp al,VK_ESCAPE
     jne @@Do

	ret
onLoop endp
;****************************
replace proc uses ebx esi edi lpTxt:DWORD,lpOld:DWORD,lpNew:DWORD
    LOCAL buffer[1024]:BYTE
    LOCAL lenOld:DWORD

    fn szLen,lpOld
    mov dword ptr[lenOld],eax
    ;---------------------
    mov esi,lpTxt
    mov edi,lpOld
    lea ebx,buffer
    ;---------------------
@@In:
    mov al,byte ptr[esi]
    or al,al
    je @@Ret
    ;--------------------- Searching a hint ----

    cmp al,byte ptr[edi]
    jne @@Next
    ;-------------------- Compare --------------
    xor ecx,ecx
    inc ecx
    ;---------------------
    jmp @@For
@@Go:
    mov al,byte ptr[esi+ecx]
    cmp al,byte ptr[edi+ecx]
    jne @@Next
    ;----------------------
    inc ecx
@@For:
    cmp ecx,dword ptr[lenOld]
    jl @@Go
    ;---------------------- FOUND ---------------
    mov edi,lpNew
@@In2:
    mov al,byte ptr[edi]
    or al,al
    je @@In3
    ;----------------------
    mov byte ptr[ebx],al
    inc ebx
    inc edi
    jmp @@In2
    ;---------------------- Append the rest text --
@@In3:
   mov al,byte ptr[esi+ecx]
   or al,al
   je @@Ret
   ;-----------------------
   mov byte ptr[ebx],al
   inc ebx
   inc esi
   jmp @@In3

@@Next:
   mov byte ptr[ebx],al
   inc ebx
   inc esi
   jmp @@In

   ;------------------------
@@Ret:
   mov byte ptr[ebx],0
   fn szCopy,addr buffer,lpTxt
	ret
replace endp
;****************************
findAll proc uses ebx esi edi lpszText:DWORD,lpBuffer:DWORD
   
    mov esi,dword ptr[lpszText]
    mov edi,dword ptr[lpBuffer]
    ;-------------------------
@@In:
    mov al,byte ptr[esi]
    or al,al
    je @@Ret
    ;------------------------
    cmp al,5Fh
    ;------------------------
    jne @@Next
    ;--------- FOUND ---------
   
@@In2: 
    mov byte ptr[edi],al
    inc edi
    inc esi
    ;-------------------------
    mov al,byte ptr[esi]
    cmp al,5Fh
    ;-------------------------
    jne @@In2
    ;-------------------------
    mov byte ptr[edi],al
    inc edi
    mov byte ptr[edi],0Ah
    inc edi
    ;-------------------------
@@Next:
    inc esi
    jmp @@In
    ;-------------------------
@@Ret:

	ret
findAll endp
end start