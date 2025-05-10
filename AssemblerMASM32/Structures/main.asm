include main.inc

.code
start:
     call main
     ;---------------
     push eax
     ;---------------
     call ExitProcess
;===========================
main proc
     LOCAL app:APPLICATION
     ;------------------
     lea ecx, app
     ;------------------
     fn app_init
     ;------------------
     call app.run
     ;------------------
	 ret
main endp 
end start