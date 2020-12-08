;===============================================================================
;
;		MouseGestureL.ahkプラグイン TaskVolume Ver.1.2 (単体動作可能)
;
;		・タスクバー上のホイール回転でボリューム変更
;		・タスクバー上の中央クリックでミュートON/OFF
;		・アプリケーションごとに自動でボリューム変更
;
;===============================================================================

;-------------------------------------------------------------------------------
; 各種設定値 (お好みで変更してください)
TV_VolumeStep	:= 1			; １回のボリュームの変化量
TV_VolColor	:= 0x00ff00		; ボリューム表示色 (0xRRGGBB)
TV_MuteColor	:= 0xff0000		; ミュート時のボリューム表示色 (0xRRGGBB)
TV_VolTrans	:= 200			; ボリューム表示の不透明度 (透明:0～不透明:255)
TV_BarBaseColor	:= 0x00ff00		; ボリュームバーの背景色 (0xRRGGBB)
TV_MuteBaseColor:= 0xff0000		; ミュート時のボリュームバー背景色 (0xRRGGBB)
TV_BarBaseTrans	:= 80			; ボリュームバー背景の不透明度 (透明:0～不透明:255)
TV_BarSizeW	:= 250			; ボリュームバーの横幅
TV_BarSizeH	:= 30			; ボリュームバーの高さ
TV_BarMarginX	:= 10			; スクリーン右端からボリュームバー右端までの距離
TV_BarMarginY	:= 50			; スクリーン下端からボリュームバー下端までの距離
TV_VolFont	:= "メイリオ"		; ボリューム表示のフォント名
TV_VolFontSize	:= 24			; ボリューム表示のフォントサイズ
TV_NameFont	:= "メイリオ"		; 定義名のフォント名
TV_NameFontSize	:= 18			; 定義名のフォントサイズ
TV_VolDispTime	:= 2000			; ボリューム表示時間 (ミリ秒)
;-------------------------------------------------------------------------------

TV_SelIndex := 1
TV_SelActive := false
TV_LoadIni()
TV_CreateWindow()
OnExit, TV_Exit
SetTimer, TV_WatchTimer, 100
Goto, TV_End


;-------------------------------------------------------------------------------
; MouseGestureL.ahk側でジェスチャーの動作に割り当てる場合は
;★ここから★
#If TV_MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::
	TV_Change("+" . TV_VolumeStep)
return

WheelDown::
	TV_Change("-" . TV_VolumeStep)
return

MButton::
	TV_Mute()
return
#If
;★ここまで★
; を削除して、TV_Change()、TV_Mute()を割り当てアクションから呼び出してください。
; その場合の条件定義は、ウィンドウクラス「Shell_TrayWnd」です。
;-------------------------------------------------------------------------------


TV_MouseIsOver(szWin="", szCtrl="")
{
	Global TV_ClassNN
	CoordMode, Mouse, Screen
	MouseGetPos,,,hWnd, TV_ClassNN, 1
    if (szWin)
    {
	    if (!WinExist(szWin . " ahk_id " . hWnd)) {
			return false
		}
	}
    if (szCtrl)
    {
		if (TV_ClassNN != szCtrl) {
			return false
		}
	}
	return true
}

TV_Change(vol, szName="")
{
	global TV_WatchTable, TV_SelIndex, TV_SelActive
	Critical
	SoundSet, vol
	TV_WatchTable[TV_SelIndex][TV_SelActive ? 4 : 3] := TV_SoundGet()
	TV_DispVolume(false, szName)
	Critical Off
}

TV_Mute()
{
	SoundSet, +1, , MUTE
	TV_DispVolume(true)
}

TV_SoundGet(fMute=false)
{
	if (fMute) {
		SoundGet, szMute,, MUTE
		StringUpper, szMute, szMute
		return szMute
	} else {
		SoundGet, vol
		return Round(vol)
	}
}

TV_CreateWindow()
{
	local clrF, clrB
	TV_Mute := TV_GetColor(clrF, clrB)
	Gui, TV_BaseWin:+HwndTV_hBaseWin -Caption +ToolWindow +AlwaysOnTop +LastFound
	WinSet, Transparent, %TV_BarBaseTrans%
	Gui, TV_BaseWin:Color, %clrB%

	Gui, TV_BarWin:+HwndTV_hBarWin -Caption +ToolWindow +AlwaysOnTop +LastFound
	WinSet, Transparent, %TV_VolTrans%
	Gui, TV_BarWin:Color, %clrF%

	local w, h
	SysGet, w, 0
	SysGet, h, 1
	TV_BarPosX := w - TV_BarMarginX - TV_BarSizeW
	TV_BarPosY := h - TV_BarMarginY - TV_BarSizeH
	TV_CreateNumberWindow(clrF)
}

TV_CreateNumberWindow(color)
{
	global
	Gui, TV_NumWin:+HwndTV_hNumWin -Caption +ToolWindow +AlwaysOnTop +LastFound
	local clrT := TV_MakeTransColor(color)
	WinSet, TransColor, % clrT . " " . TV_VolTrans
	Gui, TV_NumWin:Color, %clrT%
	Gui, TV_NumWin:Font, c%color% s%TV_VolFontSize% w600 q5, %TV_VolFont%
	Gui, TV_NumWin:Add, Text, vTV_VolVal Right, ミュートOFF
	Gui, TV_NumWin:Show, AutoSize Hide

	local x, y, w, h
	WinGetPos,,, w, h
	x := TV_BarPosX - w + 20
	y := TV_BarPosY + (TV_BarSizeH - h)/2 + 2
	Gui, TV_NumWin:Show, x%x% y%y% Hide
}

TV_ShowNameWindow(color, szName)
{
	global
	Gui, TV_NameWin:New
	Gui, TV_NameWin:+HwndTV_hNumWin -Caption +ToolWindow +AlwaysOnTop +LastFound
	local clrT := TV_MakeTransColor(color)
	WinSet, TransColor, % clrT . " " . TV_VolTrans
	Gui, TV_NameWin:Color, %clrT%
	Gui, TV_NameWin:Font, c%color% s%TV_NameFontSize% q5, %TV_NameFont%
	szName .= TV_SelActive ? " - Active" : ""
	Gui, TV_NameWin:Add, Text, vTV_Name Right, %szName%
	Gui, TV_NameWin:Show, AutoSize Hide

	local scrW, x, y, w, h
	SysGet, scrW, 0
	WinGetPos,,, w, h
	x := scrW - w + 5
	y := TV_BarPosY - h + 18
	Gui, TV_NameWin:Show, x%x% y%y% NA
}

TV_GetColor(ByRef clrF, ByRef clrB)
{
	local szMute := TV_SoundGet(true)
	clrF := (szMute = "ON") ? TV_MuteColor : TV_VolColor
	clrB := (szMute = "ON") ? TV_MuteBaseColor : TV_BarBaseColor
	return szMute
}

TV_MakeTransColor(color)
{
	r := (color >> 16) & 0xff
	g := (color >> 8) & 0xff
	b := color & 0xff
	r += (r>0) ? -1 : 1
	g += (g>0) ? -1 : 1
	b += (b>0) ? -1 : 1
	SetFormat, IntegerFast, H
	color := (r<<16) + (g<<8) + b
	color := RegExReplace(color, "^0x")
	SetFormat, IntegerFast, D
	Loop, % (6 - StrLen(color))
	{
		color := "0" . color
	}
	return color
}

TV_DispVolume(fMute=false, szName="")
{
	global
	SetTimer, TV_HideTimer, Off
	local szMute, clrF, clrB
	szMute := TV_GetColor(clrF, clrB)
	if (fMute || (TV_Mute != szMute))
	{
		TV_Mute := szMute
		Gui, TV_BaseWin:Color, %clrB%
		Gui, TV_BarWin:Color, %clrF%
		Gui, TV_NumWin:Destroy
		TV_CreateNumberWindow(clrF)
	}
	if (!WinExist("ahk_id" . TV_hBaseWin)) {
		Gui, TV_BaseWin:Show, x%TV_BarPosX% y%TV_BarPosY% w%TV_BarSizeW% h%TV_BarSizeH% NA
	}
	local vol := TV_SoundGet()
	local w := TV_BarSizeW * vol // 100
	if (w > 0) {
		Gui, TV_BarWin:Show, x%TV_BarPosX% y%TV_BarPosY% w%w% h%TV_BarSizeH% NA
	} else {
		Gui, TV_BarWin:Hide
	}

	if (fMute){
		GuiControl, TV_NumWin:, TV_VolVal, ミュート%szMute%
	} else {
		GuiControl, TV_NumWin:, TV_VolVal, %vol%
	}
	if (!WinExist("ahk_id" . TV_hNumWin)) {
		Gui, TV_NumWin:Show, NA
	}
	if (szName) {
		TV_ShowNameWindow(clrF, szName)
	}
	SetTimer, TV_HideTimer, -%TV_VolDispTime%
}

TV_HideTimer:
	Gui, TV_BaseWin:Hide
	Gui, TV_BarWin:Hide
	Gui, TV_NumWin:Hide
	Gui, TV_NameWin:Destroy
return

TV_WatchTimer:
	TV_WatchWindow()
return

TV_WatchWindow()
{
	global TV_WatchTable, TV_SelIndex, TV_SelActive
	WinGet, szActiveExe, ProcessName, A
	idx		:= 1
	fActive	:= false
	WinGet, lstWin, List,,,!!!sonzaishinai_title!!!
	Loop, %lstWin%
	{
		WinGet, szExe, ProcessName, % "ahk_id " . lstWin%A_Index%
		idxTmp := TV_TableMatch(szExe, szActiveExe, actTmp)
		if (idxTmp && (idx<=1 || idxTmp<idx)) {
			idx		:= idxTmp
			fActive := actTmp
		}
	}
	if ((TV_SelIndex  != idx)
	||	(TV_SelActive != fActive))
	{
		TV_SelIndex	 := idx
		TV_SelActive := fActive
		TV_Change(TV_WatchTable[idx][fActive ? 4 : 3], TV_WatchTable[idx][1])
	}
}

TV_TableMatch(szTarget, szActive, ByRef fActive)
{
	global TV_WatchTable
	Loop, % TV_WatchTable.MaxIndex()-1
	{
		idx := A_Index+1
		if (TV_WatchTable[idx][2] = szTarget)
		{
			if ((TV_WatchTable[idx][4] >= 0)
			&&	(szTarget = szActive))
			{
				fActive := true
				return %idx%
			}
			if (TV_WatchTable[idx][3] >= 0)
			{
				fActive := false
				return %idx%
			}
		}
	}
	return 0
}

TV_LoadIni()
{
	local name, exe, vol, act
	local szPath := RegExReplace(A_LineFile, ".ahk$", ".ini")
	IniRead, name, %szPath%, Default, Name
	IniRead, vol, %szPath%, Default, Volume
	name := (name = "ERROR") ? "Default" : name
	vol  := (vol = "ERROR" || vol<0) ? TV_SoundGet() : vol
	TV_WatchTable := [ [ name, "", vol, -1 ] ]
	Loop
	{
		IniRead, name, %szPath%, Target%A_Index%, Name
		IniRead, exe,  %szPath%, Target%A_Index%, Exe
		IniRead, vol,  %szPath%, Target%A_Index%, Volume
		IniRead, act,  %szPath%, Target%A_Index%, ActiveVolume
		if (exe = "ERROR" || exe = "") {
			break
		}
		name := (name = "ERROR" || name = "") ? exe : name
		vol  := (vol  = "ERROR" || vol  = "") ? -1 : vol
		act  := (act  = "ERROR" || act  = "") ? -1 : act
		local tempArray := Array(name, exe, vol, act)
		TV_WatchTable.Insert(tempArray)
	}
}

TV_SaveIni()
{
	local szPath := RegExReplace(A_LineFile, ".ahk$", ".ini")
	IniWrite, % TV_WatchTable[1][3], %szPath%, Default, Volume
	Loop, % TV_WatchTable.MaxIndex()-1
	{
		;IniWrite, % TV_WatchTable[A_Index+1][1], %szPath%, Target%A_Index%, Name
		;IniWrite, % TV_WatchTable[A_Index+1][2], %szPath%, Target%A_Index%, Exe
		IniWrite, % TV_WatchTable[A_Index+1][3], %szPath%, Target%A_Index%, Volume
		IniWrite, % TV_WatchTable[A_Index+1][4], %szPath%, Target%A_Index%, ActiveVolume
	}
}

TV_Exit:
	TV_SaveIni()
ExitApp

TV_End:
