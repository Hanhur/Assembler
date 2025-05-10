include \masm32\include\masm32rt.inc

APPLICATION_INTERFACE struct

     run    DWORD ?
     update DWORD ?
     
APPLICATION_INTERFACE ends

APPLICATION struct

    APPLICATION_INTERFACE <>
    object           RECT <>

APPLICATION ends

app_init   proto
app_run    proto
app_update proto

print_rect proto :DWORD

.code
app_init proc uses ebx esi edi

    ;------------
    mov dword ptr[ecx+APPLICATION.run],offset app_run
    mov dword ptr[ecx+APPLICATION.update],offset app_update
    ;------------
    lea edx,dword ptr[ecx+APPLICATION.object]
    ;------------
    mov dword ptr[edx+RECT.left],20
    mov dword ptr[edx+RECT.top],2
    mov dword ptr[edx+RECT.right],50
    mov dword ptr[edx+RECT.bottom],12
    ;------------
	ret
app_init endp
;========================================
app_run proc uses ebx esi edi

    call dword ptr[ecx+APPLICATION.update]
    ;-------------
    printf("%c%c",10,10)
    ;-------------
    inkey
	ret
app_run endp
;========================================
app_update proc uses ebx esi edi

    lea eax,dword ptr[ecx+APPLICATION.object]
    ;--------------
    push eax
    ;--------------
    call print_rect
    ;--------------
    
	ret
app_update endp
;========================================
print_rect proc uses ebx esi edi pRect:DWORD

    mov esi,pRect
    
    ;----------------------
    ;print horizontal lines
    ;----------------------
    
    mov ebx,dword ptr[esi+RECT.left]
    
    ;----------------------
    ;left top corner
    ;----------------------
    
    fn locate,ebx,dword ptr[esi+RECT.top]
    ;--------------
    printf("%c",218)  
    
    ;----------------------
    ;left bottom corner
    ;----------------------
    
    fn locate,ebx,dword ptr[esi+RECT.bottom]
    ;--------------
    printf("%c",192)
      
    inc ebx
@@ForX:
  
    fn locate,ebx,dword ptr[esi+RECT.top]
    ;---------------
    printf("%c",196)
    ;---------------
    fn locate,ebx,dword ptr[esi+RECT.bottom]
    ;---------------
    printf("%c",196)
    ;---------------
    inc ebx
    cmp ebx, dword ptr[esi+RECT.right]
    jb @@ForX
    
    ;---------------------
    ;right top corner
    ;---------------------
    
    fn locate,ebx,dword ptr[esi+RECT.top]
    ;--------------
    printf("%c",191)
    
    ;----------------------
    ;right bottom corner
    ;----------------------
    
    fn locate,ebx,dword ptr[esi+RECT.bottom]
    ;--------------
    printf("%c",217)
    
    ;----------------------
    ;print vertical lines
    ;----------------------
    
    mov ebx,dword ptr[esi+RECT.top]
    inc ebx
   
@@ForY:
  
    fn locate,dword ptr[esi+RECT.left],ebx
    ;---------------
    printf("%c",179)
    ;---------------
    fn locate,dword ptr[esi+RECT.right],ebx
    ;---------------
    printf("%c",179)
    ;---------------
    inc ebx
    cmp ebx, dword ptr[esi+RECT.bottom]
    jb @@ForY

    ;---------------

	ret
print_rect endp