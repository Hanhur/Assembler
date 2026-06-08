include main.inc

.code
start:
     fnx hInstance = GetModuleHandle,0
     ;-------------------
     fn WinMain,eax,0,0,SW_SHOWNORMAL
     ;-------------------
     fn ExitProcess,eax
     
WinMain proc hInst:DWORD,hPrev:DWORD,CommandLine:DWORD,show:DWORD
     LOCAL atom:DWORD
     LOCAL hWnd:DWORD
     LOCAL msg:MSG
     
     ;---------------------
     ;REGISTER WINDOW CLASS
     ;---------------------
     
     push hInst
     ;-------------------
     call register_class
     ;-------------------
     push eax
     pop atom
     
     ;---------------------
     ;    CREATE A WINDOW
     ;---------------------

     fn CreateWindowEx,0,atom,CADD("Crackme Demo."),WS_OVERLAPPED or WS_MINIMIZEBOX or WS_MAXIMIZEBOX or \
                       WS_SYSMENU or WS_THICKFRAME or WS_CAPTION,CW_USEDEFAULT,CW_USEDEFAULT,WINDOW_W,WINDOW_H,0,0,hInst,0
     ;---------------------                           
     push eax
     pop hWnd
     ;---------------------
     or eax,eax
     jne @F
     ;---------------------
     fn MessageBox,0,"Failed to create a window.","Error!",MB_ICONERROR  
     ;---------------------
     jmp @@Ret
@@:
     ;------------------------
     ;SET WINDOW CENTER SCREEN
     ;------------------------
     
     fn SetWindowCenterEx,hWnd,1
     
     ;---------------------
     ;SHOW NEW WINDOW
     ;---------------------
     
     fn ShowWindow,hWnd,show
     
     ;---------------------
     ;UPDATE WINDOW
     ;---------------------
     
     fn UpdateWindow,hWnd
     
     ;---------------------
     ;MESSAGE LOOP
     ;---------------------
     
@@MSG:
     fn GetMessage,addr msg,0,0,0
     ;---------------------
     or ax,ax
     je @@Ret
     ;---------------------
     fn TranslateMessage,addr msg
     ;---------------------
     fn DispatchMessage,addr msg
     ;---------------------
     jmp @@MSG

@@Ret:
     ;---------------------
     ;UNREGISTER WIDOW CLASS
     ;---------------------
     
     fn UnregisterClass,atom,hInst
     ;---------------------
     xor eax,eax
	 ret
WinMain endp
;=================================================================
WindowProc proc uses ebx esi edi hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD

    .if uMsg == WM_CREATE
    
       ;---------------------
       ;INITIALIZE CODE HERE
       ;---------------------
       
       fn on_create,hWin,hInstance
    
    .elseif uMsg == WM_DESTROY
    
       ;---------------------
       ;    DESTROY WINDOW
       ;---------------------
    
       fn PostQuitMessage,0
       
    .elseif uMsg == WM_COMMAND
    
        fn controle_handler,hWin,hInstance,wParam,lParam
        
    .elseif uMsg == WM_GETMINMAXINFO
    
        ;---------------------
        ;PRIVENT FROM RESIZING
        ;---------------------
        
        push lParam
        pop eax
        ;--------------
        mov dword ptr[eax+18h],WINDOW_W
        mov dword ptr[eax+1Ch],WINDOW_H
        mov dword ptr[eax+20h],WINDOW_W
        mov dword ptr[eax+24h],WINDOW_H
       
    .else
    
       fn DefWindowProc,hWin,uMsg,wParam,lParam
       ;---------------
       jmp @@Ret

    .endif
    
    xor eax,eax
@@Ret:
	ret
WindowProc endp
;=================================================================
register_class proc hInst:DWORD
    LOCAL wc:WNDCLASSEX
    
    mov wc.cbSize,sizeof wc
    mov wc.style,CS_HREDRAW	or CS_VREDRAW	
    mov wc.lpfnWndProc,offset WindowProc
    and wc.cbClsExtra,0
    and wc.cbWndExtra,0
    ;------------------
    push hInst
    pop wc.hInstance
    ;------------------
    fn LoadIcon,hInst,IDI_ICON
    ;------------------
    mov wc.hIcon,eax
    and wc.hIconSm,0
    ;------------------
    fn LoadCursor,0,32512
    ;------------------
    mov wc.hCursor,eax
    ;------------------
    mov wc.hbrBackground,COLOR_WINDOW
    
    ;-------------------
    ;       MENU
    ;-------------------
    
    mov wc.lpszMenuName,offset IDM_MNU
    
    ;-------------------
    ;    WINDOW CLASS
    ;-------------------
    
    mov wc.lpszClassName,chr$("Win32")
    ;-------------------
    fn RegisterClassEx,addr wc
    ;-------------------

	ret
register_class endp
end start