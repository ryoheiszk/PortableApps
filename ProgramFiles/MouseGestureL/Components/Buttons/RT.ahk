Goto,MG_RT_End

MG_RT_Enable:
	Hotkey,*WheelRight,MG_RT_DownHotkey,On
	Hotkey,*WheelRight up,MG_RT_UpHotkey,On
return

MG_RT_Disable:
	Hotkey,*WheelRight,MG_RT_DownHotkey,Off
	Hotkey,*WheelRight up,MG_RT_UpHotkey,Off
return

MG_RT_DownHotkey:
	MG_TriggerDown("RT")
return

MG_RT_UpHotkey:
	MG_TriggerUp("RT")
return

MG_RT_Down:
	SetMouseDelay,-1
	Send,{Blind}{WheelRight Down}
return

MG_RT_Up:
	SetMouseDelay,-1
	Send,{Blind}{WheelRight Up}
return

MG_RT_Check:
	if (!GetKeyState("WheelRight", "P")) {
		MG_UnpressCntRT++
		if (MG_UnpressCntRT > 3) {
			MG_TriggerUp("RT")
			SetMouseDelay,-1
			Send,{Blind}{WheelRight}
		}
	} else {
		MG_UnpressCntRT := 0
	}
return

MG_RT_End:
