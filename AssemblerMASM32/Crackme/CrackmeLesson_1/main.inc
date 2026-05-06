include \masm32\include\masm32rt.inc

WINDOW_W  = 300
WINDOW_H  = 200


WinMain         proto :DWORD, :DWORD, :DWORD, :DWORD
WindowProc      proto :DWORD, :DWORD, :DWORD, :DWORD

register_class  proto :DWORD

.data?
	hInstance dd ?