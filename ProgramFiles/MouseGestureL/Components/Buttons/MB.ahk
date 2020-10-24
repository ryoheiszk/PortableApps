Goto,MG_MB_End

MG_MB_Enable:
	Hotkey,*MButton,MG_MB_DownHotkey,On
	Hotkey,*MButton up,MG_MB_UpHotkey,On
return

MG_MB_Disable:
	Hotkey,*MButton,MG_MB_DownHotkey,Off
	Hotkey,*MButton up,MG_MB_UpHotkey,Off
return

MG_MB_DownHotkey:
	MG_TriggerDown("MB")
return

MG_MB_UpHotkey:
	MG_TriggerUp("MB")
return

MG_MB_Down:
	if (!MG_DisableDefMB) {
		SetMouseDelay,-1
		Send,{Blind}{MButton Down}
	}
return

MG_MB_Up:
	if (!MG_DisableDefMB) {
		SetMouseDelay,-1
		Send,{Blind}{MButton Up}
	}
return

MG_MB_Check:
	if (!GetKeyState("MButton", "P")) {
		MG_UnpressCntMB++
		if (MG_UnpressCntMB > 3) {
			MG_TriggerUp("MB")
			SetMouseDelay,-1
			Send,{Blind}{MButton}
		}
	} else {
		MG_UnpressCntMB := 0
	}
return

MG_MB_End:
