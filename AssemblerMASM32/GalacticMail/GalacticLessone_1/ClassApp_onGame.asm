ClassApp_onGame		proto


.code
;======================== ClassApp_onGame =======================
ClassApp_onGame proc uses ebx esi edi
	.while id_state != STATE_EXIT
		fn ClassTimer_start
		;----------------------------
		fn ClassApp_onLoop
		;----------------------------
		fn ClassApp_onRender
		;----------------------------
		fn ClassApp_onEvent
		;----------------------------
		fn ClassApp_updateState
		;----------------------------
		fn ClassTimer_delay
	.endw
	Ret
ClassApp_onGame endp