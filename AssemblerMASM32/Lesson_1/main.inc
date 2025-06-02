include \masm32\congamelib\congame.inc

includelib \masm32\congamelib\congame.lib
include CStack.asm

Main           proto
RevStr         proto :DWORD,:DWORD
fRevStr        proto :DWORD
fRevString     proto :DWORD,:DWORD
iceil          proto :DWORD,:DWORD
ceil           proto 
floor          proto


.data?
stack         STACK <?>

.data
szABC         db "abcd",0
fnum1             REAL4 4.0r
fnum2             REAL4 3.0r