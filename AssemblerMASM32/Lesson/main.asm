include main.inc

.code
start:

    ;-----------------------
    fn Main
    ;-----------------------
    fn ExitProcess,eax
    ;***********************
Main proc
    LOCAL hFile:DWORD
    LOCAL dwFileSize:DWORD
    LOCAL hMem:DWORD
    LOCAL bRead:DWORD

    fn CreateFile,offset szFileName,GENERIC_READ,0,0,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0
    ;------------------------
    mov dword ptr[hFile],eax
    cmp eax,-1
    ;------------------------
    je @@Error
    ;------------------------
    fn GetFileSize,eax,0
    ;------------------------
    mov dword ptr[dwFileSize],eax
    ;------------------------
    cmp eax, -1
    ;------------------------
    je @@Close
    ;------------------------
    inc eax
    ;------------------------
    fn LocalAlloc,LPTR,eax
    ;------------------------
    push eax
    pop hMem
    ;------------------------
    mov esi,eax
    ;------------------------
    lea ebx, bRead
    ;------------------------
    fn ReadFile,hFile,esi,dwFileSize,ebx,0
    ;------------------------
    xor eax,eax
    ;------------------------
@@While:
    mov al, byte ptr[esi]
    or al,al
    ;------------------------
    je @@Free
    ;------------------------
    ;putchar eax
    fn Putchar
    ;------------------------
    inc esi
    jmp @@While
    
@@Free:
    fn LocalFree,hMem

@@Close:
    fn CloseHandle,hFile
    ;------------------------
    ;putchar 10
    mov eax,10
    fn Putchar
    ;------------------------
    inkey
    xor eax,eax
	ret
@@Error:
    fn MessageBox,0,"File does not exist.","Error.",0
    ;-------------------------
    xor eax,eax
    inc eax
    ret
Main endp
;***********************
Putchar proc uses ebx esi edi
    LOCAL buffer:DWORD
    LOCAL bWrites:DWORD

    push eax
    pop buffer
    ;------------------
    lea esi,buffer
    lea ebx,bWrites
    ;-----------------
    ;fn GetStdHandle,STD_OUTPUT_HANDLE
    ;-----------------
    fn WriteConsole,7,esi,1,ebx,0
    ;-----------------
	ret
Putchar endp
end start