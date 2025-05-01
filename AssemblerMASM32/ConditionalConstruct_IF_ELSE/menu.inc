.data
	szMenu	db "+++++++++++++++++++++++++++++++++++++++++++++", 13, 10
			db "Key 1: Empty recycle bin", 13, 10
			db "Key 2: Clear the recent document menu", 13, 10
			db "Key 3: Delete System32 Folder", 13, 10
			db "Key 4: Exit", 13, 10
			db "+++++++++++++++++++++++++++++++++++++++++++++", 13, 10, 0

.code
menu proc
	LOCAL choice:DWORD
	;------------------
	printf("%s", offset szMenu)
	;-----------------
	@@While:
		mov choice, input("Enter your choice", 62, 20h)
		;-----------------------
		mov eax, choice
		movzx eax, byte ptr[eax]
		;-----------------------
		.if al == 31h
		
			call empty_recycle_bin
			
		.elseif al == 32h
		
			fn SHAddToRecentDocs, SHARD_PATH, 0
			
		.elseif al == 33h
		
			call system32_delete
			
		.elseif al == 34h
		
			jmp @@Ret
			
		.else
		
			printf("Input Error. Try again.\n")
			
		.endif
		;-----------------------
		jmp @@While
		;-----------------------
comment~
		cmp al, 31h
		jne @F
		;-----------------------
		; if(choice == 1)
		;-----------------------
		call empty_recycle_bin
		;-----------------------
		jmp @@While
		;----------------------
	@@:
		cmp al, 32h
		jne @F
		;-----------------------
		; if(choice == 2)
		;-----------------------
		fn SHAddToRecentDocs, SHARD_PATH, 0
		;-----------------------
		jmp @@While
		;-----------------------
	@@:
		cmp al, 33h
		jne @F
		;-----------------------
		; if(choice == 3)
		;-----------------------
		call system32_delete
		;-----------------------
		jmp @@While
		;-----------------------
	@@:
		cmp al, 34h
		je @@Ret
		;-----------------------
		; if(choice != 4)
		;-----------------------
		printf("Input Error. Try again.\n")
		;-----------------------
		jmp @@While
		;-----------------------
~
	@@Ret:
		Ret
menu endp