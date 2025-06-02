include \masm32\congamelib\congame.inc
includelib \masm32\congamelib\congame.lib
;***************************************************
Main              proto
onInit            proto
onStart           proto
onLoop            proto
;***************************************************
findAll           proto :DWORD,:DWORD
replace           proto :DWORD,:DWORD,:DWORD




.data

lpText           db '        Giraffes love to carry various _ NUMEROUS Plural _ all day long.',10
                 db '        Giraffes are also famous for eating wonderful _ NUMEROUS Plural _,',10
                 db '        but after that, they often hurt _ PART OF BODY _.',10
                 db '        If giraffes find _ NUMBER _ _ NUMEROUS Plural _, ',10
                 db '        they have instantly falls off _ PART OF BODY _.',13,10,0
                 ;----------------------------------------------------------------------------------
szHints          db 128 dup(0)
                 ;----------------------------------------------------------------------------------
szNewText        db 1024 dup(0)



