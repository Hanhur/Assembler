BTN_EXIT  = 100

BTN_W     = 52
BTN_H     = 24

controles_create_button    proto :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

.code
;==================================================================
controles_create_button proc uses ebx esi edi hParent:DWORD,hInst:DWORD,button_id:DWORD,lpszCaption:DWORD,x:DWORD,y:DWORD,w:DWORD,h:DWORD,style:DWORD
    
    push style
    pop eax
    or eax,WS_CHILD or WS_VISIBLE
    push eax
    pop style
    
    ;---------- [Create the Button Control] ----------
    
    fn CreateWindowEx,0,CADD("BUTTON"),lpszCaption,style,x,y,w,h,hParent,button_id,hInst,0
    ;-------------------------------------------------
	ret
controles_create_button endp
;==================================================================