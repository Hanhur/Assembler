include main.inc

.code
start:
      call main
      ;----------
      push eax
      ;----------
      call ExitProcess
;==========================================
main proc
    LOCAL v:DWORD
    
    ;--------------------------
    ;        EXAMPLE
    ;--------------------------
    
    fn solution, offset even_str
    ;fn solution, offset odd_str
    ;-----------
    push eax
    pop v
    ;-----------
    fn show_solution, eax
    ;-----------
    fn delete_solution, v


    ;--------------------------
    ;YOUR SOLUTIN FUNCTION HERE
    ;--------------------------
    
    nop
    nop
    
    
    ;--------------------------
    inkey
    ;-----------
    xor eax, eax
	ret
main endp
end start