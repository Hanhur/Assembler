;****************************************************
;					public function					*
;****************************************************
ClassTimer_start		proto
ClassTimer_delay		proto

;****************************************************
;					private function				*
;****************************************************
ClassTimer_get_ticks	proto


.data
	frame_rate	dd 34
	startTicks	dd 0


.code
;====================== ClassTimer_start =========================
ClassTimer_start proc uses ebx esi edi
	fn GetTickCount
	;---------------------------------
	mov dword ptr[startTicks], eax
	;---------------------------------
	Ret
ClassTimer_start endp
;====================== ClassTimer_delay =========================
ClassTimer_delay proc uses ebx esi edi
	fn ClassTimer_get_ticks
	;----------------------------------
	cmp eax, dword ptr[frame_rate]
	jge @@Ret
	;----------------------------------
	mov ebx, dword ptr[frame_rate]
	;----------------------------------
	sub ebx, eax
	;----------------------------------
	fn Sleep, ebx
	;----------------------------------
	@@Ret:
		Ret
ClassTimer_delay endp
;====================== ClassTimer_get_ticks =====================
ClassTimer_get_ticks proc uses ebx esi edi
	fn GetTickCount
	;-------------------------------------
	sub eax, dword ptr[startTicks]
	;-------------------------------------
	Ret
ClassTimer_get_ticks endp