SetWindowCenterEx proto :DWORD,:DWORD

.code
;**********************************************************
;mode = 0; full screen
;mode = 1; work area only
;**********************************************************
SetWindowCenterEx proc uses ebx esi edi hWin:DWORD,mode:DWORD
     LOCAL mi:MONITORINFO
	 LOCAL rc:RECT
	 
     fn IsWindow,hWin
	 ;-------------------
	 or eax,eax
	 je @@Ret
	 ;-------------------
     fn IsZoomed,hWin
	 ;-------------------
     or eax,eax
	 jne @@Ret
     ;-------------------
     fn GetWindowRect,hWin,addr rc
	 ;-------------------
	 mov mi.cbSize,sizeof MONITORINFO
	 ;------------------
	 fn MonitorFromWindow,hWin,MONITOR_DEFAULTTONEAREST
     ;------------------
     lea esi,mi
     ;------------------
     fn GetMonitorInfo,eax,esi
     ;------------------
     lea esi,mi.rcMonitor
     ;------------------
     cmp mode,0
     je @F
     ;------------------
     lea esi,mi.rcWork  
@@:
     mov eax,dword ptr[esi+8]   ;right
     sub eax,dword ptr[esi]     ;left
     ;------------------
     mov ebx,rc.right
     sub ebx,rc.left
     ;------------------
     cmp ebx,eax
     jg @@Ret
     ;------------------
     mov ecx,dword ptr[esi+12] ;bottom
     sub ecx,dword ptr[esi+4]  ;top
     ;------------------
     mov edx,rc.bottom
     sub edx,rc.top
     ;------------------
     cmp edx,ecx
     jg @@Ret
     ;------------------
     shr eax,1
     shr ebx,1
     ;------------------
     add eax,dword ptr[esi]
     sub eax,ebx             ;cx
     ;------------------
     shr ecx,1
     shr edx,1
     ;------------------
     add ecx,dword ptr[esi+4]
     sub ecx,edx             ;cy
     ;------------------
     fn SetWindowPos,hWin,NULL,eax,ecx,NULL,NULL,SWP_NOSIZE or SWP_NOZORDER

@@Ret:
      ret
SetWindowCenterEx endp
;**********************************************************