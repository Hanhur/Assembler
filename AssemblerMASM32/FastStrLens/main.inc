include \masm32\include\masm32rt.inc

include asm32.inc

dword_has_null_byte proto :DWORD

.data
str1   db "1234", 0
str2   db "56789", 0
buffer db 32 dup(0)

.code
;===========================================================================
;        Alan Mycroft's the null-byte detection algorithm.
;         
;         ((dword - 0x01010101) & ~dword & 0x80808080)
;
;The output is zero if all four bytes of dword are nonzero. 
;The output will have 0x80 in the position of the first byte of zero.
;
;This method was invented by Alan Mycroft and published in 1987.
;Alan Mycroft's method is a variant of the null-byte detection algorithm. 
;The post suggests that bytes containing zero are turned into 0x80, 
;while other bytes are turned into 0x00.The algorithm then checks for 
;the presence of 0x80 in the dword number to detect the null byte.
;=============================================================================
dword_has_null_byte proc uses ebx esi edi number:DWORD

    push number 
    pop eax                            
    lea ecx, dword ptr[eax - 01010101h]   
    not eax                            
    and ecx, eax                        
    and ecx, 80808080h                  
    ;----------------
    push ecx
    pop eax
    
	ret
dword_has_null_byte endp