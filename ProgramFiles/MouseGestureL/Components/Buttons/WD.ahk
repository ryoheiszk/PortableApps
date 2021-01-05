Goto, MG_WD_End

MG_WD_Enable:
	if (!MG_AlwaysHook) {
		MG_WD_HookEnabled := Func("MG_IsHookEnabled_WD")
		Hotkey, If, % MG_WD_HookEnabled
	}
	Hotkey, *WheelDown, MG_WD_Hotkey, On
	Hotkey, If
	MG_WD_Enabled := 1
return

MG_WD_Disable:
	Hotkey, *WheelDown, MG_WD_Hotkey, Off
	MG_WD_Enabled := 0
return

MG_WD_Hotkey:
	MG_ButtonPress("WD")
return

MG_WD_Press:
	MG_SendButton("WD", "WheelDown")
return

MG_WD_End:
