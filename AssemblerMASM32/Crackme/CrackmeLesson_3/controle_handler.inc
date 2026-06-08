
controle_handler proto :DWORD,:DWORD,:DWORD,:DWORD

.code
controle_handler proc uses ebx esi edi hWin:DWORD,hInst:DWORD,wParam:DWORD,lParam:DWORD

    push wParam
    pop eax
    ;--------------
    cmp eax,BTN_EXIT
    jne @F
    ;--------------
@@Close:

    fn SendMessage,hWin,WM_CLOSE,0,0
    ;--------------
    jmp @@Ret
    ;--------------
    
@@:
    cmp ax,IDM_EXIT
    je @@Close
    ;--------------
    cmp ax,IDM_ABOUT
    jne @F
    ;--------------
    ;ABOUT MENU
    ;--------------
    jmp @@Ret
@@:
    cmp ax,IDM_REG
    jne @@Ret
    ;--------------
    ;REGISTER MENU
    ;--------------
    nop
   
@@Ret:
	ret
controle_handler endp