include \masm32\include\masm32rt.inc

include helper.inc
include controles.inc
include controle_handler.inc
include onCreate.inc

WINDOW_W  = 300
WINDOW_H  = 200

IDI_ICON  = 1
IDM_MNU   = 1000
IDM_EXIT  = 1003
IDM_REG   = 1007
IDM_ABOUT = 1009

WinMain         proto :DWORD,:DWORD,:DWORD,:DWORD
WindowProc      proto :DWORD,:DWORD,:DWORD,:DWORD

register_class  proto :DWORD

.data?
hInstance dd ?