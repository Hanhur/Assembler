include \masm32\include\masm32rt.inc

.data
;------------------------------------------------------
msgMenu     db "+++++++++++++++++++++++++++++++++++++++",13,10
            db "   Base calculator Beginner's Guide",13,10
            db "+++++++++++++++++++++++++++++++++++++++",13,10,0
;------------------------------------------------------
msg1        db "Enter the first number:",62,20h,0
msg2        db "Enter the second number:",62,20h,0
msgOperator db "Enter the operator (+, -, *, /):",62,20h,0
;------------------------------------------------------
msgPromt    db 13,10,"Press 'q' to quit, or 'ENTER' to continue:",62,20h,0
msgInvalid  db "Invalid input. Please try again.",13,10,0