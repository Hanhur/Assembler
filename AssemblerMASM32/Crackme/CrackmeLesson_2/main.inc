include \masm32\include\masm32rt.inc

include helper.inc

WINDOW_W  = 300
WINDOW_H  = 250


WinMain         proto :DWORD,:DWORD,:DWORD,:DWORD
WindowProc      proto :DWORD,:DWORD,:DWORD,:DWORD

register_class  proto :DWORD

.data?
hInstance dd ?