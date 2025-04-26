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

	jmp @@While
	;-----------------
	Ret
menu endp