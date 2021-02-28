;Description = ShiftWheelDown
Goto, MG_ShiftWheelDown_End

MG_ShiftWheelDown_Enable:
	if (!MG_AlwaysHook) {
		MG_ShiftWheelDown_HookEnabled := Func("MG_IsHookEnabled_ShiftWheelDown")
		Hotkey, If, % MG_ShiftWheelDown_HookEnabled
	}
	Hotkey, +WheelDown, MG_ShiftWheelDown_DownHotkey, On
	Hotkey, +WheelDown up, MG_ShiftWheelDown_UpHotkey, On
	Hotkey, If
	MG_ShiftWheelDown_Enabled := 1
return

MG_ShiftWheelDown_Disable:
	Hotkey, +WheelDown, MG_ShiftWheelDown_DownHotkey, Off
	Hotkey, +WheelDown up, MG_ShiftWheelDown_UpHotkey, Off
	MG_ShiftWheelDown_Enabled := 0
return

MG_ShiftWheelDown_DownHotkey:
	MG_TriggerDown("ShiftWheelDown")
return

MG_ShiftWheelDown_UpHotkey:
	MG_TriggerUp("ShiftWheelDown")
return

MG_ShiftWheelDown_Down:
	MG_SendButton("ShiftWheelDown", "+WheelDown", "Down")
return

MG_ShiftWheelDown_Up:
	MG_SendButton("ShiftWheelDown", "+WheelDown", "Up")
return

MG_ShiftWheelDown_Check:
	MG_CheckButton("ShiftWheelDown", "+WheelDown")
return

MG_ShiftWheelDown_End:
