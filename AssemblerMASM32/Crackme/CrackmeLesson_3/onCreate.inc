
on_create proto :DWORD,:DWORD

.code
on_create proc uses ebx esi edi hWin:DWORD,hInst:DWORD

    ;--------------------------
    ;      CREATE BUTTONS
    ;--------------------------
    
    fn controles_create_button,hWin,hInst,BTN_EXIT,CADD("Exit"),224,110,BTN_W,BTN_H,BS_TEXT or BS_PUSHBUTTON or \
                                  BS_CENTER or BS_VCENTER

	ret
on_create endp