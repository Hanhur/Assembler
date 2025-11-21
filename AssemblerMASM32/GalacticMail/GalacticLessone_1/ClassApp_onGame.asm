ClassApp_onGame		proto

.code
ClassApp_onGame proc uses ebx esi edi
	.while id_state != STATE_EXIT
		fn ClassApp_onLoop
		;-----------------------------
		fn ClassApp_onRender
		;-----------------------------
		fn ClassApp_onEvent
		;-----------------------------
		fn ClassApp_updateState
	.endw
	Ret
ClassApp_onGame endp