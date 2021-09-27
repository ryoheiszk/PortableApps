MG_IniFileVersion=1.38
MG_8Dir=0
MG_ActiveAsTarget=0
MG_Interval=20
MG_AlwaysHook=0
MG_PrvntCtxtMenu=1
MG_Threshold=20
MG_LongThresholdX=9999
MG_LongThresholdY=9999
MG_LongThreshold=700
MG_TimeoutThreshold=2
MG_Timeout=180
MG_DGInterval=0
MG_TmReleaseTrigger=2
MG_ORangeDefault=3
MG_ORangeA=3
MG_ORangeB=3
MG_EdgeInterval=20
MG_EdgeIndiv=0
MG_CornerX=1
MG_CornerY=1
MG_DisableDefMB=0
MG_DisableDefX1B=0
MG_DisableDefX2B=0
MG_UseNavi=1
MG_UseExNavi=3
MG_NaviInterval=10
MG_NaviPersist=0
MG_ExNaviTransBG=1
MG_ExNaviFG=000000
MG_ExNaviBG=FFFFFF
MG_ExNaviTranspcy=255
MG_ExNaviSize=24
MG_ExNaviSpacing=2
MG_ExNaviPadding=4
MG_ExNaviMargin=8
MG_AdNaviFG=FFFFFF
MG_AdNaviNI=7F7F7F
MG_AdNaviBG=000000
MG_AdNaviTranspcy=220
MG_AdNaviSize=11
MG_AdNaviFont=メイリオ
MG_AdNaviPosition=0
MG_AdNaviPaddingL=6
MG_AdNaviPaddingR=6
MG_AdNaviPaddingT=3
MG_AdNaviPaddingB=3
MG_AdNaviRound=2
MG_AdNaviMargin=14
MG_AdNaviSpaceX=2
MG_AdNaviSpaceY=2
MG_AdNaviOnClick=0
MG_ShowTrail=0
MG_DrawTrailWnd=1
MG_TrailColor=0000FF
MG_TrailTranspcy=255
MG_TrailWidth=3
MG_TrailStartMove=3
MG_TrailInterval=10
MG_ShowLogs=0
MG_LogPosition=4
MG_LogPosX=0
MG_LogPosY=0
MG_LogMax=20
MG_LogSizeW=400
MG_LogInterval=500
MG_LogFG=FFFFFF
MG_LogBG=000000
MG_LogTranspcy=100
MG_LogFontSize=10
MG_LogFont=MS UI Gothic
MG_EditCommand=
MG_HotkeyEnable=
MG_HotkeyNavi=
MG_HotkeyReload=
MG_ScriptEditor=C:\tools\vscode\Code.exe
MG_TraySubmenu=0
MG_AdjustDlg=0
MG_DlgHeightLimit=800
MG_FoldTarget=0
MG_DisableWarning=0
MG_ActvtExclud := []
MG_MaxLength=10
MG_Triggers=RB_MB
MG_SubTriggers=LB_WU_WD


Goto, MG_RB_End

MG_RB_Enable:
	if (!MG_AlwaysHook) {
		MG_RB_HookEnabled := Func("MG_IsHookEnabled_RB")
		Hotkey, If, % MG_RB_HookEnabled
	}
	Hotkey, *RButton, MG_RB_DownHotkey, On
	Hotkey, *RButton up, MG_RB_UpHotkey, On
	Hotkey, If
	MG_RB_Enabled := 1
return

MG_RB_Disable:
	Hotkey, *RButton, MG_RB_DownHotkey, Off
	Hotkey, *RButton up, MG_RB_UpHotkey, Off
	MG_RB_Enabled := 0
return

MG_RB_DownHotkey:
	MG_TriggerDown("RB")
return

MG_RB_UpHotkey:
	MG_TriggerUp("RB")
return

MG_RB_Down:
	MG_SendButton("RB", "RButton", "Down")
return

MG_RB_Up:
	MG_SendButton("RB", "RButton", "Up")
return

MG_RB_Check:
	MG_CheckButton("RB", "RButton")
return

MG_RB_End:


Goto, MG_MB_End

MG_MB_Enable:
	if (!MG_AlwaysHook) {
		MG_MB_HookEnabled := Func("MG_IsHookEnabled_MB")
		Hotkey, If, % MG_MB_HookEnabled
	}
	Hotkey, *MButton, MG_MB_DownHotkey, On
	Hotkey, *MButton up, MG_MB_UpHotkey, On
	Hotkey, If
	MG_MB_Enabled := 1
return

MG_MB_Disable:
	Hotkey, *MButton, MG_MB_DownHotkey, Off
	Hotkey, *MButton up, MG_MB_UpHotkey, Off
	MG_MB_Enabled := 0
return

MG_MB_DownHotkey:
	MG_TriggerDown("MB")
return

MG_MB_UpHotkey:
	MG_TriggerUp("MB")
return

MG_MB_Down:
	if (!MG_DisableDefMB) {
		MG_SendButton("MB", "MButton", "Down")
	}
return

MG_MB_Up:
	if (!MG_DisableDefMB) {
		MG_SendButton("MB", "MButton", "Up")
	}
return

MG_MB_Check:
	MG_CheckButton("MB", "MButton")
return

MG_MB_End:


Goto, MG_LB_End

MG_LB_Enable:
	if (!MG_AlwaysHook) {
		MG_LB_HookEnabled := Func("MG_IsHookEnabled_LB")
		Hotkey, If, % MG_LB_HookEnabled
	}
	Hotkey, *LButton, MG_LB_DownHotkey, On
	Hotkey, *LButton up, MG_LB_UpHotkey, On
	Hotkey, If
	MG_LB_Enabled := 1
return

MG_LB_Disable:
	Hotkey, *LButton, MG_LB_DownHotkey, Off
	Hotkey, *LButton up, MG_LB_UpHotkey, Off
	MG_LB_Enabled := 0
return

MG_LB_DownHotkey:
	MG_TriggerDown("LB")
return

MG_LB_UpHotkey:
	MG_TriggerUp("LB")
return

MG_LB_Down:
	MG_SendButton("LB", "LButton", "Down")
return

MG_LB_Up:
	MG_SendButton("LB", "LButton", "Up")
return

MG_LB_Check:
	MG_CheckButton("LB", "LButton")
return

MG_LB_End:


Goto, MG_WU_End

MG_WU_Enable:
	if (!MG_AlwaysHook) {
		MG_WU_HookEnabled := Func("MG_IsHookEnabled_WU")
		Hotkey, If, % MG_WU_HookEnabled
	}
	Hotkey, *WheelUp, MG_WU_Hotkey, On
	Hotkey, If
	MG_WU_Enabled := 1
return

MG_WU_Disable:
	Hotkey, *WheelUp, MG_WU_Hotkey, Off
	MG_WU_Enabled := 0
return

MG_WU_Hotkey:
	MG_ButtonPress("WU")
return

MG_WU_Press:
	MG_SendButton("WU", "WheelUp")
return

MG_WU_End:


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


Goto, MG_Config_End


MG_IsDisable() {
	global
	return ((MG_WClass="GHOST_WindowClass") || (MG_WClass="Chrome_WidgetWin_2") || (compareClassNN("SWT_Window021")))
}

MG_IsTarget1() {
	global
	return ((MG_Exe="iexplore.exe") || (MG_Exe="chrome.exe") || (MG_Exe="firefox.exe") || (MG_Exe="Biscuit.exe"))
}

MG_IsTarget2() {
	global
	return ((MG_WClass="CabinetWClass") || (MG_WClass="ExploreWClass") || (MG_WClass="Progman") || (MG_WClass="WorkerW"))
}

MG_IsTarget3() {
	global
	return (MG_IsTarget2() && ((MG_WClass="WorkerW")))
}

MG_IsTarget4() {
	global
	return (MG_IsTarget2() && ((MG_TreeListHitTest())))
}

MG_IsTarget5() {
	global
	return (1)
}

MG_IsTarget6() {
	global
	return (MG_IsTarget5() && ((MG_Exe="Code.exe")))
}

MG_IsTarget7() {
	global
	return (MG_IsTarget5() && ((MG_Exe="EXCEL.EXE")))
}

MG_IsTarget8() {
	global
	return (MG_IsTarget5() && ((MG_WClass="gdkWindowToplevel")))
}

MG_IsTarget9() {
	global
	return (MG_IsTarget5() && ((MG_WClass="AviUtl")))
}

MG_IsTarget10() {
	global
	return (MG_IsTarget5() && ((MG_WClass="PPTFrameClass")))
}

MG_IsTarget11() {
	global
	return (MG_IsTarget5() && ((MG_WClass="CatMemoNoteMainFrame")))
}

MG_IsTarget12() {
	global
	return (MG_IsTarget5() && ((MG_Exe="ONENOTE.EXE")))
}


MG_Gesture_MB_WU_:
	;左スクロール
	
	MG_Scroll2("H", -8, 0)
return

MG_GetAction_MB_WU_:
	MG_ActionStr := "左スクロール"
return

MG_Gesture_MB_WD_:
	;右スクロール
	
	MG_Scroll2("H", 8, 0)
return

MG_GetAction_MB_WD_:
	MG_ActionStr := "右スクロール"
return

MG_Gesture_RB_U_:
	if (MG_IsTarget9()) {
		;中間点を追加
		
		Send, p
	}else{
		;上スクロール
		
		Send, {Blind}{PgUp}{PgUp} 
	}
return

MG_GetAction_RB_U_:
	if (MG_IsTarget9()) {
		MG_ActionStr := "中間点を追加"
	}else{
		MG_ActionStr := "上スクロール" 
	}
return

MG_Gesture_RB_D_:
	if (MG_IsTarget9()) {
		;分割
		
		Send, s
	}else{
		;下スクロール
		
		Send, {Blind}{PgDn}{PgDn} 
	}
return

MG_GetAction_RB_D_:
	if (MG_IsTarget9()) {
		MG_ActionStr := "分割"
	}else{
		MG_ActionStr := "下スクロール" 
	}
return

MG_Gesture_RB_RU_:
	;上端スクロール
	
	Send,^{Home}
return

MG_GetAction_RB_RU_:
	MG_ActionStr := "上端スクロール"
return

MG_Gesture_RB_RD_:
	;下端スクロール
	
	Send,^{End}
return

MG_GetAction_RB_RD_:
	MG_ActionStr := "下端スクロール"
return

MG_Gesture_RB_L_:
	if (MG_IsTarget8()) {
		;アンドゥ
		
		Send, ^z
	} else if (MG_IsTarget9()) {
		;アンドゥ
		
		Send, ^z
	}else{
		;戻る
		
		Send, !{Left} 
	}
return

MG_GetAction_RB_L_:
	if (MG_IsTarget8()) {
		MG_ActionStr := "アンドゥ"
	} else if (MG_IsTarget9()) {
		MG_ActionStr := "アンドゥ"
	}else{
		MG_ActionStr := "戻る" 
	}
return

MG_Gesture_RB_R_:
	if (MG_IsTarget8()) {
		;リドゥ
		
		Send, ^y
	}else{
		;進む
		
		Send, !{Right} 
	}
return

MG_GetAction_RB_R_:
	if (MG_IsTarget8()) {
		MG_ActionStr := "リドゥ"
	}else{
		MG_ActionStr := "進む" 
	}
return

MG_Gesture_RB_UD_:
	if (MG_IsTarget12()) {
		;更新
		
		Send, +{F9}
	}else{
		;更新
		
		Send, {F5} 
	}
return

MG_GetAction_RB_UD_:
	if (MG_IsTarget12()) {
		MG_ActionStr := "更新"
	}else{
		MG_ActionStr := "更新" 
	}
return

MG_Gesture_RB_UR_:
	if (MG_IsTarget12()) {
		;下のページ
		
		Send, ^{PgDn}
	} else if (MG_IsTarget11()) {
		;右のタブ
		
		Send, ^!+{Right}
	}else{
		;次のタブ
		
		Send, ^{Tab} 
	}
return

MG_GetAction_RB_UR_:
	if (MG_IsTarget12()) {
		MG_ActionStr := "下のページ"
	} else if (MG_IsTarget11()) {
		MG_ActionStr := "右のタブ"
	}else{
		MG_ActionStr := "次のタブ" 
	}
return

MG_Gesture_RB_UL_:
	if (MG_IsTarget12()) {
		;上のページ
		
		Send, ^{PgUp}
	} else if (MG_IsTarget11()) {
		;左のタブ
		
		Send, ^!+{Left}
	}else{
		;前のタブ
		
		Send, ^+{Tab} 
	}
return

MG_GetAction_RB_UL_:
	if (MG_IsTarget12()) {
		MG_ActionStr := "上のページ"
	} else if (MG_IsTarget11()) {
		MG_ActionStr := "左のタブ"
	}else{
		MG_ActionStr := "前のタブ" 
	}
return

MG_Gesture_RB_DL_:
	;閉じたタブを復元
	
	Send, +^t
return

MG_GetAction_RB_DL_:
	MG_ActionStr := "閉じたタブを復元"
return

MG_Gesture_RB_DR_:
	if (MG_IsTarget1()) {
		;タブを閉じる
		
		Send, ^w
	} else if (MG_IsTarget6()) {
		;タブを閉じる
		
		Send, ^w
	}else{
		;タブ・ウィンドウを閉じる
		
		Send, !{F4} 
	}
return

MG_GetAction_RB_DR_:
	if (MG_IsTarget1()) {
		MG_ActionStr := "タブを閉じる"
	} else if (MG_IsTarget6()) {
		MG_ActionStr := "タブを閉じる"
	}else{
		MG_ActionStr := "タブ・ウィンドウを閉じる" 
	}
return

MG_Gesture_MB_DR_:
	if (MG_IsTarget1()) {
		;タブを閉じる
		
		Send, ^w
	} else if (MG_IsTarget6()) {
		;タブを閉じる
		
		Send, ^w
	}else{
		;タブ・ウィンドウを閉じる
		
		Send, !{F4} 
	}
return

MG_GetAction_MB_DR_:
	if (MG_IsTarget1()) {
		MG_ActionStr := "タブを閉じる"
	} else if (MG_IsTarget6()) {
		MG_ActionStr := "タブを閉じる"
	}else{
		MG_ActionStr := "タブ・ウィンドウを閉じる" 
	}
return

MG_Gesture_RB_UDR_:
	;ウィンドウを閉じる
	
	Send, !{F4}
return

MG_GetAction_RB_UDR_:
	MG_ActionStr := "ウィンドウを閉じる"
return

MG_Gesture_RB_LU_:
	if (MG_IsTarget1()) {
		;Ctrl+L
		
		Send, ^l
	} else if (MG_IsTarget12()) {
		;ウィンドウを複製
		
		Send, ^m
	}else{
		;ウィンドウを複製
		
		Send, ^n 
	}
return

MG_GetAction_RB_LU_:
	if (MG_IsTarget1()) {
		MG_ActionStr := "Ctrl+L"
	} else if (MG_IsTarget12()) {
		MG_ActionStr := "ウィンドウを複製"
	}else{
		MG_ActionStr := "ウィンドウを複製" 
	}
return

MG_Gesture_RB_LD_:
	if (MG_IsTarget1()) {
		;ページ内検索
		
		Send, ^f
	}else{
		;新規フォルダ作成
		
		Send, ^+N 
	}
return

MG_GetAction_RB_LD_:
	if (MG_IsTarget1()) {
		MG_ActionStr := "ページ内検索"
	}else{
		MG_ActionStr := "新規フォルダ作成" 
	}
return

MG_Gesture_RB_LR_:
	;コピー
	
	Send, ^c
return

MG_GetAction_RB_LR_:
	MG_ActionStr := "コピー"
return

MG_Gesture_RB_RL_:
	;ペースト
	
	Send, ^v
return

MG_GetAction_RB_RL_:
	MG_ActionStr := "ペースト"
return

MG_Gesture_RB_RDR_:
	;カット
	
	Send, ^x
return

MG_GetAction_RB_RDR_:
	MG_ActionStr := "カット"
return

MG_Gesture_RB_LRL_:
	;アンドゥ
	
	Send, ^z
return

MG_GetAction_RB_LRL_:
	MG_ActionStr := "アンドゥ"
return

MG_Gesture_RB_RLR_:
	;リドゥ
	
	Send, ^y
return

MG_GetAction_RB_RLR_:
	MG_ActionStr := "リドゥ"
return

MG_Gesture_RB_URD_:
	;全選択
	
	Send, ^a
return

MG_GetAction_RB_URD_:
	MG_ActionStr := "全選択"
return

MG_Gesture_RB_UDU_:
	;最大化
	
	WinMaximize
return

MG_GetAction_RB_UDU_:
	MG_ActionStr := "最大化"
return

MG_Gesture_RB_DUD_:
	;最小化
	
	WinMinimize
return

MG_GetAction_RB_DUD_:
	MG_ActionStr := "最小化"
return

MG_Gesture_RB_DLD_:
	;タスク切り替え
	
	Send, !{Tab}
	
return

MG_GetAction_RB_DLD_:
	MG_ActionStr := "タスク切り替え"
return

MG_Gesture_RB_DLDR_:
	;タスク切り替え(保持)
	
	Send, ^!{Tab}
return

MG_GetAction_RB_DLDR_:
	MG_ActionStr := "タスク切り替え(保持)"
return

MG_Gesture_RB_DRU_:
	;リネーム
	
	Send, {F2}
return

MG_GetAction_RB_DRU_:
	MG_ActionStr := "リネーム"
return

MG_Gesture_RB_DU_:
	;Enter
	
	Send, {Blind}{Enter}
return

MG_GetAction_RB_DU_:
	MG_ActionStr := "Enter"
return

MG_Gesture_RB_LUR_:
	;Backspace
	
	Send, {Blind}{Backspace}
return

MG_GetAction_RB_LUR_:
	MG_ActionStr := "Backspace"
return

MG_Gesture_RB_LDL_:
	;Space
	
	Send, {Blind}{Space}
return

MG_GetAction_RB_LDL_:
	MG_ActionStr := "Space"
return

MG_Gesture_RB_RDL_:
	;Delete
	
	Send, {Blind}{Delete}
return

MG_GetAction_RB_RDL_:
	MG_ActionStr := "Delete"
return

MG_Gesture_RB_RLDR_:
	;Tab
	
	Send, {Blind}{Tab}
return

MG_GetAction_RB_RLDR_:
	MG_ActionStr := "Tab"
return

MG_Gesture_RB_LDRLDR_:
	;ESC
	
	Send, {Blind}{ESC}
return

MG_GetAction_RB_LDRLDR_:
	MG_ActionStr := "ESC"
return

MG_Gesture_RB_LDR_:
	;上書き保存
	
	Send,^s
	myToolTipFunction("上書き保存", 200)
return

MG_GetAction_RB_LDR_:
	MG_ActionStr := "上書き保存"
return

MG_Gesture_RB_RUL_:
	if (MG_IsTarget9()) {
		;複製
		
		Send, ^d
	}else{
		MG_Cancel() 
	}
return

MG_GetAction_RB_RUL_:
	if (MG_IsTarget9()) {
		MG_ActionStr := "複製"
	}else{
		MG_ActionStr := "" 
	}
return

MG_Gesture_RB_RLD_:
	if (MG_IsTarget10()) {
		;新しいスライド
		
		Send, ^m
	} else if (MG_IsTarget12()) {
		;OneNoteテキストモード
		
		Send, {Alt}dt
	}else{
		;新しいタブ
		
		Send, ^t 
	}
return

MG_GetAction_RB_RLD_:
	if (MG_IsTarget10()) {
		MG_ActionStr := "新しいスライド"
	} else if (MG_IsTarget12()) {
		MG_ActionStr := "OneNoteテキストモード"
	}else{
		MG_ActionStr := "新しいタブ" 
	}
return

MG_Gesture_RB_URDR_:
	;1行選択
	
	Send, {Home}{Shift Down}{End}{Shift Up}
return

MG_GetAction_RB_URDR_:
	MG_ActionStr := "1行選択"
return

MG_Gesture_MB_LRL_:
	; Win + Left
	
	Send, #{Left}
return

MG_GetAction_MB_LRL_:
	MG_ActionStr := " Win + Left"
return

MG_Gesture_MB_RLR_:
	; Win + Right
	
	Send, #{Right}
return

MG_GetAction_MB_RLR_:
	MG_ActionStr := " Win + Right"
return


MG_Gesture_RB_MB_WU_:
	;↑
	
	MG_StopNavi()
	Send, {Blind}{Up}
return

MG_GetAction_RB_MB_WU_:
	MG_ActionStr := "↑"
return

MG_Gesture_RB_MB_WD_:
	;↓
	
	MG_StopNavi()
	Send, {Blind}{Down}
return

MG_GetAction_RB_MB_WD_:
	MG_ActionStr := "↓"
return

MG_Gesture_RB_WU_:
	;←
	
	Send, {Blind}{Left}
	;If (WinActive("Netflix") OR WinActive("netflix")) {
	;	Send, {Space 2}
	;}
return

MG_GetAction_RB_WU_:
	MG_ActionStr := "←"
return

MG_Gesture_RB_WD_:
	;→
	
	Send, {Blind}{Right}
	;If (WinActive("Netflix") OR WinActive("netflix")) {
	;	Send, {Space 2}
	;}
return

MG_GetAction_RB_WD_:
	MG_ActionStr := "→"
return


MG_Gesture_RB_RDLD:
	;音量調整
	
	step_vol := 2
	MG_StopNavi()
	Sleep, 500
	KeyWait, RButton, Up
	SetTimer, RemoveToolTip, -500
	step_vol := ""
	Return
	
	#If, step_vol!=""
		WheelUp::volume_change(step_vol)
		WheelDown::volume_change(-step_vol)
	#If
	
	volume_change(step) {
		SoundGet, vol_now
		Setformat, Float, 1.0
		vol_now += step
		If (vol_now < 0) {
			vol_now := 0
		} Else If (vol_now > 100) {
			vol_now := 100
		}
		SoundSet, vol_now
		ToolTip, 音量  :  %vol_now%
		Return
	}
	
return

MG_GetAction_RB_RDLD:
	MG_ActionStr := "音量調整"
return

MG_Gesture_RB_UDLR_:
	;Ctrl+Shift+F8
	;(AudioSwitcher)
	
	Send, ^+{F8}
	myToolTipFunction("Ctrl+Shift+F8", 750)
return

MG_GetAction_RB_UDLR_:
	MG_ActionStr := "Ctrl+Shift+F8"
return

MG_Gesture_RB_UDLD_:
	;Ctrl+Shift+F7
	;(AudioSwitcher)
	
	Send, ^+{F7}
	myToolTipFunction("Ctrl+Shift+F7", 750)
return

MG_GetAction_RB_UDLD_:
	MG_ActionStr := "Ctrl+Shift+F7"
return


MG_Gesture_MB_UR_:
	;Win + 1
	
	Send, #{1}
return

MG_GetAction_MB_UR_:
	MG_ActionStr := "Win + 1"
return

MG_Gesture_MB_URL_:
	;Win + 2
	
	Send, #{2}
return

MG_GetAction_MB_URL_:
	MG_ActionStr := "Win + 2"
return

MG_Gesture_MB_URLR_:
	;Win + 3
	
	Send, #{3}
return

MG_GetAction_MB_URLR_:
	MG_ActionStr := "Win + 3"
return

MG_Gesture_MB_URLRL_:
	;Win + 4
	
	Send, #{4}
return

MG_GetAction_MB_URLRL_:
	MG_ActionStr := "Win + 4"
return


MG_Gesture_RB_DRD_:
	if (MG_IsTarget11()) {
		;非表示モード切り替え
		
		Send, ^!h
	}else{
		;CatMemoNote表示
		
		Send, ^+!m
		 
	}
return

MG_GetAction_RB_DRD_:
	if (MG_IsTarget11()) {
		MG_ActionStr := "非表示モード切り替え"
	}else{
		MG_ActionStr := "CatMemoNote表示" 
	}
return

MG_Gesture_RB_LDRUD_:
	;Clibor表示
	
	Send, !c
return

MG_GetAction_RB_LDRUD_:
	MG_ActionStr := "Clibor表示"
return

MG_Gesture_RB_URDL_:
	if (MG_IsTarget12()) {
		;OneNoteペンモード
		
		Send, {Alt}dp{Right 5}{Enter}
	}else{
		MG_Cancel() 
	}
return

MG_GetAction_RB_URDL_:
	if (MG_IsTarget12()) {
		MG_ActionStr := "OneNoteペンモード"
	}else{
		MG_ActionStr := "" 
	}
return

MG_Gesture_RB_RULD_:
	;OneNote 画面の領域
	
	Target := "ahk_exe ONENOTE.EXE"
	If (WinExist(Target)) {
		WinActivate, %Target%
		Send, {Alt}nr
	}
return

MG_GetAction_RB_RULD_:
	MG_ActionStr := "OneNote 画面の領域"
return

MG_Gesture_RB_LRU_:
	;タスクマネージャー起動
	
	Send, ^+{Escape}
return

MG_GetAction_RB_LRU_:
	MG_ActionStr := "タスクマネージャー起動"
return

MG_Gesture_RB_LDLD_:
	;Ctrl+Alt+F(CliborFIFO)
	
	Send, ^!f
return

MG_GetAction_RB_LDLD_:
	MG_ActionStr := "Ctrl+Alt+F(CliborFIFO)"
return

MG_Gesture_RB_LDRDL_:
	
return

MG_GetAction_RB_LDRDL_:
	
return

MG_Gesture_MB_UD_:
	;ウィンドウを左のモニターへ
	
	Send, #+{Left}
return

MG_GetAction_MB_UD_:
	MG_ActionStr := "ウィンドウを左のモニターへ"
return

MG_Gesture_MB_R_:
	;右の仮想デスクトップ
	
	Send, ^#{Right}
return

MG_GetAction_MB_R_:
	MG_ActionStr := "右の仮想デスクトップ"
return

MG_Gesture_MB_L_:
	;左の仮想デスクトップ
	
	Send, ^#{Left}
return

MG_GetAction_MB_L_:
	MG_ActionStr := "左の仮想デスクトップ"
return

MG_Gesture_MB_RLD_:
	;デスクトップ一覧
	
	Send, #{Tab}
return

MG_GetAction_MB_RLD_:
	MG_ActionStr := "デスクトップ一覧"
return

MG_Gesture_RB_RDLDR_:
	;自動ログイン(Ctrl+Alt+Space)
	
	Send, {vkF2}{vkF3}
	Send, ^!{Space}
return

MG_GetAction_RB_RDLDR_:
	MG_ActionStr := "自動ログイン(Ctrl+Alt+Space)"
return

MG_Gesture_RB_RDUDUR_:
	;Screenpresso表示
	
	Send, ^+!w
return

MG_GetAction_RB_RDUDUR_:
	MG_ActionStr := "Screenpresso表示"
return

MG_Gesture_RB_DUDU_:
	;PrintScreen
	
	Send, {PrintScreen}
return

MG_GetAction_RB_DUDU_:
	MG_ActionStr := "PrintScreen"
return

MG_Gesture_RB_DUDUL_:
	;映像授業用Prsc
	
	CoordMode, Screen
	
	; PrintScreen(ScreenPresso)
	GoSub, MG_Gesture_RB_DUDU_
	
	Sleep, 500
	
	; 初期座標記録
	MouseGetPos, oldMouseX, oldMouseY
	
	; カーソルを上のモニタへ
	MouseMove, 200, -1000, 0
	
	While (1) {
		If (GetKeyState("LButton", "P")) {
			Send, {LButton Down}
			MouseMove, 1700, -200, 0
			While (1) {
				If (!GetKeyState("LButton", "P")) {
					Send, {LButton Up}
					Goto, PrscEnd
				}
	
				Sleep, 50
			}
		}
		
		If (GetKeyState("RButton", "P")) {
			Goto, PrscEnd
		}
		
		Sleep, 50
	}
	
	PrscEnd:
	; (変更前)MouseMove, oldMouseX, oldMouseY
	MouseMove, 1500, 850, 0
return

MG_GetAction_RB_DUDUL_:
	MG_ActionStr := "映像授業用Prsc"
return

MG_Gesture_RB_DUL_:
	;スクリーンキーボード
	
	Send, ^#o
return

MG_GetAction_RB_DUL_:
	MG_ActionStr := "スクリーンキーボード"
return

MG_Gesture_MB_DU_:
	
return

MG_GetAction_MB_DU_:
	
return

MG_Gesture_RB_RDLU:
	
return

MG_GetAction_RB_RDLU:
	
return


MG_Gesture_RB_:
	;アクティブ化処理
	;指定サイズ未満でアクティブ化しない
	
	minWidth := 500
	minHeight := 200
	
	WinGetPos, , , width, height, A
	If ((width>minWidth) || (height>minHeight)) {
		MouseGetPos, , , underMouseID1
		WinActivate, ahk_id %underMouseID1%
	}
	
return

MG_GetAction_RB_:
	MG_ActionStr := "アクティブ化処理"
return

MG_Gesture_RB_LB_:
	;空でもこのジェスチャが登録されていないと
	;ContinuousActivationがバグる
return

MG_GetAction_RB_LB_:
	MG_ActionStr := "空でもこのジェスチャが登録されていないと"
return

MG_Gesture_MB__:
	if (MG_IsTarget4()) {
		; 新しいウィンドウでフォルダを開く
		
		Send, {RButton}e
	}else{
		MG_Cancel() 
	}
return

MG_GetAction_MB__:
	if (MG_IsTarget4()) {
		MG_ActionStr := " 新しいウィンドウでフォルダを開く"
	}else{
		MG_ActionStr := "" 
	}
return


MG_IsHookEnabled_RB() {
	global
	MG_TriggerCount ? : MG_GetMousePosInfo()
	return (MG_RB_Enabled && (MG_TriggerCount || (!MG_IsDisable())))
}

MG_IsHookEnabled_MB() {
	global
	MG_TriggerCount ? : MG_GetMousePosInfo()
	return (MG_MB_Enabled && (MG_TriggerCount || (!MG_IsDisable())))
}

MG_IsHookEnabled_LB() {
	global
	return (MG_LB_Enabled && MG_TriggerCount)
}

MG_IsHookEnabled_WU() {
	global
	return (MG_WU_Enabled && MG_TriggerCount)
}

MG_IsHookEnabled_WD() {
	global
	return (MG_WD_Enabled && MG_TriggerCount)
}



MG_Config_end: