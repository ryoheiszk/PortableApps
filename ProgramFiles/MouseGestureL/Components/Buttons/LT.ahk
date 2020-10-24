Goto,MG_LT_End

MG_LT_Enable:
	Hotkey,*WheelLeft,MG_LT_DownHotkey,On
	Hotkey,*WheelLeft up,MG_LT_UpHotkey,On
return

MG_LT_Disable:
	Hotkey,*WheelLeft,MG_LT_DownHotkey,Off
	Hotkey,*WheelLeft up,MG_LT_UpHotkey,Off
return

MG_LT_DownHotkey:
	MG_TriggerDown("LT")
return

MG_LT_UpHotkey:
	MG_TriggerUp("LT")
return

MG_LT_Down:
	SetMouseDelay,-1
	Send,{Blind}{WheelLeft Down}
return

MG_LT_Up:
	SetMouseDelay,-1
	Send,{Blind}{WheelLeft Up}
return

MG_LT_Check:
	if (!GetKeyState("WheelLeft", "P")) {
		MG_UnpressCntLT++
		if (MG_UnpressCntLT > 3) {
			MG_TriggerUp("LT")
			SetMouseDelay,-1
			Send,{Blind}{WheelLeft}
		}
	} else {
		MG_UnpressCntLT := 0
	}
return

MG_LT_End:
