
.data
szIntro   db "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++",13,10
          db "                     Arrays & Loop Tutorial by Tempesta                         ",13,10
          db "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++",13,10,13,10,0
.code
init proc uses ebx esi edi

    fn console_init,80,25,CADD("Demo Tutorial")
    ;--------------
    fn set_console_cursor,0
    ;--------------
    fn set_console_center_screen
    ;--------------
    fn set_text_color,CADD("Black"),CADD("LightBlue")
    ;--------------
    lea eax,szIntro
    ;---------------
    printf("%s",eax)
    ;---------------

	ret
init endp