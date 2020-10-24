;===============================================================================
;
;		MouseGestureL.ahk - Common Functions Library
;
;														Created by Pyonkichi
;===============================================================================
MG_Version := 1.30

MG_RuleNames =
(LTrim Join|
	WClass
	WClass_[NPTBR][PTBR]?
	CClass
	CClass_[NPTBR][PTBR]?
	Title
	Title_[NPTBR][PTBR]?
	Exe
	Exe_[NPTBR][PTBR]?
	Custom
	Custom_N
	Include
	Include_N
)
MG_SaveModificationObj := Func("SaveModification")
MG_TgDelim := "/"
MG_EncKey := "7j^t@ZE;HRUdTM^N@WqQNsocLMuuPzC4K$Zofb@BKXrLF#cWw*HQcAW@hqVxpLdi%YVND&R29ZcakZHSrwr$x!gKE^SR3&nAKU9z759*YsmbCUH%9VuNZEx*aVoe7H2@QwraX$#miB9r&2QRB2B3hXw!9covRFDXatp6kU#JERR#tZLiPrCoCf$FWt7ZHkp!#iE8K2nSbRyCwuV%rtSFCN&u4LcvD^vAuDZ^UUzdfCVwrExeP2tgnC6*BjBFG&U5"
if (A_Is64bitOS) {
	EnvGet, A_ProgramFilesX86, ProgramFiles(x86)
} else {
	A_ProgramFilesX86 := A_ProgramFiles
}
Goto MG_CommonLibEnd

;-------------------------------------------------------------------------------
; Reload Gesture Configurations
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
MG_Reload()
{
	RunWait, %A_AhkPath% "%A_ScriptDir%\MG_Edit.ahk" /ini2ahk
	Reload
}

;-------------------------------------------------------------------------------
; Edit Gesture Configurations
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
MG_Edit()
{
	global
	if (MG_EditCommand) {
		Run, %MG_EditCommand%
		return
	}
	MG_SearchPlugins()
	local t1:=0, t2:=0
	FileGetTime, t1, %A_ScriptDir%\Config\MG_Config.ahk
	RunWait, %A_AhkPath% "%A_ScriptDir%\MG_Edit.ahk"
	FileGetTime, t2, %A_ScriptDir%\Config\MG_Config.ahk
	if (t2 > t1)
	{
		Reload
		CheckConfigurationError()
	}
}

;-------------------------------------------------------------------------------
; Wait Error Message
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
CheckConfigurationError()
{
	global MC_LngButton001, MC_LngButton002, MC_LngMessage002
	WinWait, MouseGestureL.ahk ahk_class #32770, Error
	if (ErrorLevel==0)
	{
		ControlGetText, szMsg1, Static1
		ControlGetText, szMsg2, Static2
		WinClose
		Gui, MGW_Err:New
		Gui, MGW_Err:+HWNDhWnd
		Gui, MGW_Err:Add, Text, x10 y10, % MC_LngMessage002 . szMsg1 . szMsg2
		Gui, MGW_Err:Add, Button, gOnSendClipboard x+-250 y+16 w160 h26, %MC_LngButton002%
		Gui, MGW_Err:Add, Button, gOnMsgClosed x+10 yp+0 w80 h26, %MC_LngButton001%
		Gui, MGW_Err:Show, ,
		WinWaitClose, ahk_id %hWnd%
	}
	return

	;---------------------------------------------------------------------------
	; Copy to Clipboard
OnSendClipboard:
	Clipboard := szMsg1 . szMsg2
	Gui, MGW_Err:Destroy
	return

	;---------------------------------------------------------------------------
	; Canceled
OnMsgClosed:
MGW_ErrGuiClose:
MGW_ErrGuiEscape:
	Gui, MGW_Err:Destroy
	return
}

;-------------------------------------------------------------------------------
; Check whether configuration files exist
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_CheckConfigFiles()
{
	global MG_IsEdit
	szConfDir := A_ScriptDir . "\Config"
	szNewIni := szConfDir . "\MouseGestureL.ini"
	szOldIni := A_ScriptDir . "\MouseGesture.ini"
	bExists := true
	if (!FileExist(szConfDir)) {
		FileCreateDir, %szConfDir%
	}
	if (!FileExist(szNewIni))
	{
		if (FileExist(szOldIni)) {
			FileCopy, %szOldIni%, %szNewIni%
		}
		bExists := false
	}
	if (!MG_IsEdit)
	{
		if (!bExists) {
			MG_Edit()
		}
		else if (!FileExist(szConfDir . "\MG_Config.ahk")) {
			MG_Reload()
		}
	}
	return bExists
}

;-------------------------------------------------------------------------------
; Load Ini File
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
MG_LoadIniFile(szIniData="")
{
	global
	Target_Count  := 0
	Gesture_Count := 0
	if (!szIniData) {
		FileRead, szIniData, % A_ScriptDir . "\Config\MouseGestureL.ini"
	}
	MG_LoadIni(szIniData)
	Config_IniFileVersion := MG_Version
}

;-------------------------------------------------------------------------------
; Convert ini string to variables
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
MG_LoadIni(szIni, tpos=0, gpos=0)
{
	global
	local szLine, $, $1, $2, com, SName, tidx, tname, cnt, gidx, rcount, acount
		, bGes, parent, lv, tstart, bChild, lvdiff, shift, num, swap, LastIdx:=[0]

	szIni .= "`n[EndOfIni]`n"
	SName := ""
	tstart := Target_Count + 1
	gstart := Gesture_Count + 1
	bChild := false
	Loop, parse, szIni, `n, `r%A_Tab%%A_Space%
	{
		;-----------------------------------------------------------------------
		; Read one line : 行データ取得
		;-----------------------------------------------------------------------
		szLine := A_LoopField
		;.......................................................................
		; Start comments : 範囲コメント開始
		if (RegExMatch(szLine, "^\s*\/\*"))
		{
			if (!RegExMatch(szLine, "\*\/\s*$")){
				com := 1
			}
		}
		;.......................................................................
		; End comments : 範囲コメント終了
		else if (RegExMatch(szLine, "\*\/\s*$"))
		{
			com := 0
		}
		;.......................................................................
		; Skip other comments : その他コメントはスキップ
		else if (RegExMatch(szLine, "^\s*#")||com)
		{
		}
		;-----------------------------------------------------------------------
		; Section : セクション
		;-----------------------------------------------------------------------
		else if (RegExMatch(szLine, "^\[(.+)\]$", $))
		{
			if (SName == "")
			{
				; Section has not been found.
			}
			;.......................................................................
 			; Previous section is gesture : 前のセクションがジェスチャーだった場合
			else if (bGes)
			{
				if (GestureIndexOf(SName))
				{
					cnt := 1
					Loop
					{
						cnt++
						tname := SName . " (" . cnt . ")"
						if (!GestureIndexOf(tname)) {
							SName := tname
							break
						}
					}
				}
				Gesture_%gidx%_Count := acount
				if (!Gesture_%gidx%_Name)
				{
					Gesture_%gidx%_Name := SName
					Gesture_Count++
					MG_ImportedG := (gpos > 0) ? gidx : 0
				}
			}
			;.......................................................................
			; Previous section is condition : 前のセクションが条件定義だった場合
			else if (SName != "Settings")
			{
				if (lv==1 && TargetIndexOf(SName))
				{
					cnt := 1
					Loop {
						cnt++
						tname := SName . " (" . cnt . ")"
						if (!TargetIndexOf(tname)) {
							SName := tname
							break
						}
					}
				}
				Target_%tidx%_Count := rcount
				if (!Target_%tidx%_Name)
				{
					Target_%tidx%_Name := SName
					Target_Count++
					LastIdx[lv] := tidx
					MG_ImportedT := (tpos > 0) ? tidx : 0
				}
			}
			;.......................................................................
			SName := $1
			tidx := Target_Count + 1
			Target_%tidx%_Name	:= ""
			Target_%tidx%_Icon	:= 0
			Target_%tidx%_IsAnd	:= 0
			Target_%tidx%_Level := 1
			Target_%tidx%_Parent := ""
			Target_%tidx%_NotInh := 0
			rcount := 0
			gidx := Gesture_Count + 1
			Gesture_%gidx%_Name		:= ""
			Gesture_%gidx%_Patterns	:= ""
			Gesture_%gidx%_Default	:= ""
			acount := 0
			bGes := false
			lv := 1
		}
		;-----------------------------------------------------------------------
		; Entry : エントリ
		;-----------------------------------------------------------------------
		else if (RegExMatch(szLine, "^(.+?)\s*=\s*(.*?)$", $))
		{
			if (SName = "Settings")
			{
				if ($1="UserName" || $1="Password") {
					$2 := MG_StrEncDec($2)
				}
				Config_%$1% := $2
			}
			;.......................................................................
			; Target rule : ターゲットルール
			else if (RegExMatch($1, "^(" . MG_RuleNames . ")$"))
			{
				if (!MG_RuleExists(tidx, $1, $2)) {
					rcount++
					Target_%tidx%_%rcount%_Type	 := $1
					Target_%tidx%_%rcount%_Value := $2
				}
			}
			;.......................................................................
			; Target Icon : ターゲットのアイコン
			else if (MG_hImageList && $1="Icon")
			{
				Target_%tidx%_IconFile := $2
				Target_%tidx%_Icon := MG_SerchSameIcon($2)
				if (!Target_%tidx%_Icon) {
					RegExMatch($2, "^(.+?)\s*,\s*(.*?)$", $)
					Target_%tidx%_Icon := IL_Add(MG_hImageList, MG_VarInStr($1), $2)
				}
			}
			;.......................................................................
			; Target rule and mode : ターゲットルールANDモード
			else if ($1 = "And")
			{
				Target_%tidx%_IsAnd := $2
			}
			;.......................................................................
			; Target nesting level
			else if ($1 = "Level")
			{
				lv := $2 - 1
				if (LastIdx[lv]) {
					Target_%tidx%_Parent := LastIdx[lv]
				} else if (!bChild) {
					bChild := true
					Target_%tidx%_Parent := (tpos > 1) ? tpos : Target_Count
				} else {
					lv := $2 + lvdiff - 1
					Target_%tidx%_Parent := LastIdx[lv]
				}
				parent := Target_%tidx%_Parent
				lv := Target_%parent%_Level + 1
				if (tstart == tidx) {
					lvdiff := lv - $2
				}
				Target_%tidx%_Level := lv
			}
			;.......................................................................
			; Target does not inherit parent rules
			else if ($1 = "NotInherit")
			{
				Target_%tidx%_NotInh := $2
			}
			;.......................................................................
			; Gesture : ジェスチャー
			else if ($1 = "G")
			{
				bGes := true
				if ($2) {
					Join(Gesture_%gidx%_Patterns, $2)
				}
			}
			;.......................................................................
			; Bound Action : 割り当てアクション
			else if (bGes)
			{
				if (!MG_ActionExists(gidx, $1))
				{
					if (Config_IniFileVersion < 1.20) {
						$2 := RegExReplace($2, "(?<!\t)\t", "<MG_CR>")
					}
					acount++
					Gesture_%gidx%_%acount%_Target := $1
					Gesture_%gidx%_%acount%_Action := $2
				}
			}
		}
	}
	;---------------------------------------------------------------------------
	; Move the imported targets to current position
	;---------------------------------------------------------------------------
	if (MG_ImportedT && (tpos>1 || !bChild))
	{
		if (!bChild) {
			num := Func("GetGroupTargetNum").(tpos)
			tpos += num - 1
		}
		shift := tstart - tpos - 1
		if (shift > 0)
		{
			swap := Func("TargetSwap")
			Loop, % Target_Count - tstart + 1
			{
				tidx := tstart + A_Index - 1
				if (Target_%tidx%_Parent >= tstart) {
					Target_%tidx%_Parent -= shift
				}
				Loop, %shift%
				{
					swap.(tidx, tidx-1)
					if (Target_%tidx%_Level>1 && Target_%tidx%_Parent>tpos) {
						Target_%tidx%_Parent++
					}
					tidx--
				}
			}
		}
		MG_ImportedT := tpos + 1
	}
	;---------------------------------------------------------------------------
	; Move the imported gestures to current position
	;---------------------------------------------------------------------------
	if (MG_ImportedG)
	{
		shift := gstart - gpos - 1
		if (shift > 0)
		{
			swap := Func("GestureSwap")
			Loop, % Gesture_Count - gstart + 1
			{
				gidx := gstart + A_Index - 1
				Loop, %shift% {
					swap.(gidx, gidx-1)
					gidx--
				}
			}
		}
		MG_ImportedG := gpos + 1
	}
}

;-------------------------------------------------------------------------------
; Check whether specified rule exists
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_RuleExists(iTarget, szType, szValue)
{
	global
	Loop, % Target_%iTarget%_Count
	{
		if ((Target_%iTarget%_%A_Index%_Type  = szType)
		&&	(Target_%iTarget%_%A_Index%_Value = szValue))
		{
			return true
		}
	}
	return false
}

;-------------------------------------------------------------------------------
; Check whether specified action exists
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_ActionExists(iGesture, szTarget)
{
	global
	Loop, % Gesture_%iGesture%_Count
	{
		if (Gesture_%iGesture%_%A_Index%_Target = szTarget) {
			return A_Index
		}
	}
	return 0
}

;-------------------------------------------------------------------------------
; Retrieve Target Index by Name
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
TargetIndexOf(name)
{
	local idx:=1, ret:=0
	
	if (name = MC_DefTargetName) {
		return 1
	}
	Loop, Parse, name, %MG_TgDelim%
	{
		if (!A_LoopField) {
			break
		}
		while (idx <= Target_Count)
		{
			if (Target_%idx%_Name = A_LoopField) {
				ret:=idx
				break
			}
			idx++
		}
		idx++
	}
	return ret
}

;-------------------------------------------------------------------------------
; Retrieve Gesture Index by Name
;														Implemented by lukewarm
;-------------------------------------------------------------------------------
GestureIndexOf(name)
{
	global
	Loop, %Gesture_Count%
	{
		if (Gesture_%A_Index%_Name = name) {
			return A_Index
		}
	}
	return 0
}

;-------------------------------------------------------------------------------
; Retrieve Gesture Index by Gesture String
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_FindGesture(szGesture)
{
	global
	Loop, %Gesture_Count%
	{
		local idxGes := A_Index
		Loop, Parse, Gesture_%A_Index%_Patterns, `n
		{
			if (A_LoopField && (A_LoopField = szGesture)) {
				return idxGes
			}
		}
	}
	return 0
}

;-------------------------------------------------------------------------------
; Serch Target Icon Filename
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_SerchSameIcon(szIconFile)
{
	global
	Loop, %Target_Count%
	{
		if (Target_%A_Index%_IconFile = szIconFile) {
			return Target_%A_Index%_Icon
		}
	}
	return 0
}

;-------------------------------------------------------------------------------
; Combine strings with delimiter
;														Implemented by lukewarm
;-------------------------------------------------------------------------------
Join(ByRef list, value, delim="`n")
{
	list := list ? (list . delim . value) : value
}

;-------------------------------------------------------------------------------
; Replace Variables in String
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_VarInStr(str)
{
	out := str
	while (RegExMatch(out, ".*%(.+?)%.*", $)) {
		out := RegExReplace(out, "%" $1 "%", %$1%)
	}
	return out
}

;-------------------------------------------------------------------------------
; Encrypt / Decrypt String
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_StrEncDec(str, bEnc=false)
{
	global MG_EncKey
	out := ""
	strlen := StrLen(str)
	keylen := StrLen(MG_EncKey)
	pos1 := 1
	pos2 := (bEnc ? strlen : StrLen(RegExReplace(str, "\?"))) + 1
	while (pos1 <= strlen)
	{
		code := Asc(SubStr(str, pos1, 1))
		if (!bEnc && code==0x3F) {
			pos1++
			code := Asc(SubStr(str, pos1, 1)) - 0x41
		}
		code ^= Asc(SubStr(MG_EncKey, pos2, 1))
		if (bEnc && (code<=0x20 || code==0x25 || code==0x3F || code==0x60)) {
			out .= "?"
			code += 0x41
		}
		out .= Chr(code)
		pos1++, pos2++
		if (pos2 > keylen) {
			pos2 := 1
		}
	}
	return out
}

;-------------------------------------------------------------------------------
; Check whether the operating system is recent one
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_IsNewOS()
{
	return (A_OSVersion!="WIN_NT4" && A_OSVersion!="WIN_2000"
		&&	A_OSVersion!="WIN_XP"  && A_OSVersion!="WIN_2003")
}

;-------------------------------------------------------------------------------
; Check and Select Language
;	fChoose : 0:Check whether language data is loaded
;			  1:Show "Choose Language" Dialog Box
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_CheckLanguage(fChoose=0)
{
	global MG_Language

	if (!fChoose)
	{
		; Check Language Data
		if (MG_Language)
		{
			return
		}
		; Language file does not exist
		; -> Select language automatically by LCID
		static szLanguage
		if (A_Language==0411)
		{
			IfExist, %A_ScriptDir%\Languages\Japanese.ahk
			{
				szLanguage := "Japanese"
				Goto OnLngSelected
			}
		}
		else ;	if (A_Language==0409 || A_Language==0809)
		{
			IfExist, %A_ScriptDir%\Languages\English.ahk
			{
				szLanguage := "English"
				Goto OnLngSelected
			}
		}
	}
	;...........................................................................
	; Retrieve Name of Language Files
	szList := ""
	Loop, %A_ScriptDir%\Languages\*.ahk
	{
		if (A_LoopFileName != "MG_Language.ahk")
		{
			szList .= A_LoopFileName . "|"
		}
	}
	;...........................................................................
	; Show Choose Language Dialog Box
	Gui, MGW_Lng:New
	Gui, MGW_Lng:-MaximizeBox -MinimizeBox +HWNDhWnd
	Gui, MGW_Lng:Add, Text, x10 y10, Choose your language:
	Gui, MGW_Lng:Add, DropDownList, VszLanguage xp+0 y+10 w180, % RegExReplace(szList, ".ahk")
	Gui, MGW_Lng:Add, Button, gOnLngSelected x+-168 y+10 w80 Default, OK
	Gui, MGW_Lng:Add, Button, gOnLngCanceled x+8 yp+0 w80, &Cancel
	GuiControl, MGW_Lng:Choose, szLanguage, English
	Gui, MGW_Lng:Show, , Choose Language

	WinWaitClose, ahk_id %hWnd%
	return

	;---------------------------------------------------------------------------
	; Accepted
OnLngSelected:
	Gui, MGW_Lng:Submit
	file := FileOpen(A_ScriptDir . "\Languages\" . szLanguage . ".ahk", "r", "UTF-8")
	if (file)
	{
		szLng := file.Read(file.Length)
		file.Close
		if (!RegExMatch(szLng, "m)^[\s\t]*MG_Language\s*:=\s*RegExReplace"))
		{
			MsgBox, ERROR : Language file is invalid.
			Goto, OnLngCanceled
		}
		file := FileOpen(A_ScriptDir . "\Languages\MG_Language.ahk", "w `n", "UTF-8")
		if (!file)
		{
			MsgBox, ERROR : Failed in file writing.
			Goto, OnLngCanceled
		}
		file.Write("#" . "Include %A_ScriptDir%\Languages\" . szLanguage . ".ahk`n")
		file.Close
	}
	Reload

	;---------------------------------------------------------------------------
	; Canceled
OnLngCanceled:
MGW_LngGuiClose:
MGW_LngGuiEscape:
	if (fChoose)
	{
		Gui, MGW_Lng:Destroy
		return
	}
	else
	{
		ExitApp
	}
}

;-------------------------------------------------------------------------------
; Search Plugins
;	return=1 : Plugin Include Script has been Updated
;	return=0 : Plugin Include Script has Not been Changed
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_SearchPlugins()
{
	;...........................................................................
	; Search Plugin Script Files
	szInc := ""
	Loop, %A_ScriptDir%\Plugins\*.ahk
	{
		if (A_LoopFileName != "MG_Plugin.ahk")
		{
			szInc .= "#" . "Include *i %A_ScriptDir%\Plugins\" . A_LoopFileName . "`n"
		}
	}
	if (szInc == "") {
		return 0
	}
	;...........................................................................
	; Check if Plugin Files are Added or Removed
	file := FileOpen(A_ScriptDir . "\Plugins\MG_Plugin.ahk", "r `n", "UTF-8")
	if (file)
	{
		szCur := file.Read(file.Length)
		file.Close
		if (szCur == szInc) {
			return 0
		}
	}
	;...........................................................................
	; Write Plugin Include Script
	file := FileOpen(A_ScriptDir . "\Plugins\MG_Plugin.ahk", "w `n", "UTF-8")
	if (!file) {
		return 0
	}
	file.Write(szInc)
	file.Close
	return 1
}

;-------------------------------------------------------------------------------
; Show Help Document
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_ShowHelp()
{
	global MC_HelpFile, MC_LngMessage001
	IfWinExist, MouseGestureL-Help ahk_class HH Parent
	{
		WinActivate
	}
	else if(FileExist(A_ScriptDir . "\Docs\" . MC_HelpFile))
	{
		Run, %A_ScriptDir%\Docs\%MC_HelpFile%
	}
	else
	{
		MsgBox, %MC_LngMessage001%
	}
}

;-------------------------------------------------------------------------------
; Get monitor rectangle that includes specified coordinates
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_GetMonitorRect(ptX, ptY, ByRef monL=0, ByRef monT=0, ByRef monR=0, ByRef monB=0, fWork=false)
{
	pt := (ptY<<32) | (ptX & 0xffffffff)
	hMon := DllCall("user32.dll\MonitorFromPoint", "UInt64",pt, "UInt",2, "Ptr")
	VarSetCapacity(infMon, 40, 0)
	NumPut(40, infMon, 0, "UInt")
	res := DllCall("user32.dll\GetMonitorInfo", "Ptr",hMon, "Ptr",&infMon, "UInt")
	offset := fWork ? 20 : 4
	monL := NumGet(infMon, offset+ 0, "Int")
	monT := NumGet(infMon, offset+ 4, "Int")
	monR := NumGet(infMon, offset+ 8, "Int")
	monB := NumGet(infMon, offset+12, "Int")
}

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
;	Plugin Menus
;
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;-------------------------------------------------------------------------------
; Regisger Plugin Menu
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_AddPluginMenu(szName="", szCommand="")
{
	global
	if (MG_IsEdit) {
		return
	}
	MG_PluginMenuCount++
	MG_PluginMenu%MG_PluginMenuCount%_Name	  := szName
	MG_PluginMenu%MG_PluginMenuCount%_Command := szCommand
}

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
;	Custom Condition Templates
;
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;-------------------------------------------------------------------------------
; Regisger Custom Condition Category
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
MG_AddConditionCategory(key, name)
{
	global
	if (!MG_IsEdit
	||	CustomExpressions_%category%_Count)
	{
		return
	}
	Menu, CustomExpressions_%key%, Add
	Menu, CustomExpressions_%key%, DeleteAll
	Menu, CustomExpressions, Add, %name%, :CustomExpressions_%key%
}

;-------------------------------------------------------------------------------
; Regisger Custom Condition
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
MG_AddCustomCondition(category, name="", value="")
{
	global
	if (!MG_IsEdit) {
		return
	}
	Menu, CustomExpressions_%category%, Add, %name%, CustomExpressionsMenuSelect
	local cnt := CustomExpressions_%category%_Count
	cnt := cnt ? cnt+1 : 1
	CustomExpressions_%category%_Count := cnt
	CustomExpressions_%category%_%cnt% := value
	return

	;---------------------------------------------------------------------------
	; The menu item has been selected
CustomExpressionsMenuSelect:
	if(IsLabel(%A_ThisMenu%_%A_ThisMenuItemPos%)){
		GoSub,% %A_ThisMenu%_%A_ThisMenuItemPos%
	}else{
		MG_SetRuleValue(%A_ThisMenu%_%A_ThisMenuItemPos%)
	}
	return
}

;-------------------------------------------------------------------------------
; Set Rule Value
;														Implemented by lukewarm
;-------------------------------------------------------------------------------
MG_SetRuleValue(val)
{
	GuiControl, MEW_Main:, ERuleValue, %val%
}


;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
;	Action Templates
;
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;-------------------------------------------------------------------------------
; Regisger Action Category
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_AddActionCategory(key="Others", name="???")
{
	global
	if (!MG_IsEdit) {
		return
	}
	local idx := GetActionCategoryIdx(key)
	if (idx) {
		ActionCategory%idx%_Name := name
	}
	else {
		if (key = "Others") {
			idx := "Temp"
		}
		else {
			ActionCategory_Count++
			idx := ActionCategory_Count
		}
		ActionCategory%idx%_Count := 0
		ActionCategory%idx%_Key	  := key
		ActionCategory%idx%_Name  := name
	}
	GuiControl, MEW_Main:, DDLActionCategory, `n
}

;-------------------------------------------------------------------------------
; Regisger Action Template
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
MG_AddActionTemplate(category, name, script)
{
	global
	if (!MG_IsEdit) {
		return
	}
	ActionCategory1_Count++
	ActionTitle1_%ActionCategory1_Count% := name
	ActionTemplate1_%ActionCategory1_Count% := script

	local idx := GetActionCategoryIdx(category)
	if (!idx)
	{
		MG_AddActionCategory(category)
		idx := (category = "Others") ? "Temp" : ActionCategory_Count
	}
	ActionCategory%idx%_Count++
	local cnt := ActionCategory%idx%_Count
	ActionTitle%idx%_%cnt% := name
	ActionTemplate%idx%_%cnt% := script
}

;-------------------------------------------------------------------------------
; Get Action Category Index by Key
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
GetActionCategoryIdx(key)
{
	global
	if ((key = "Others") && ActionCategoryTemp_Key) {
		return "Temp"
	}
	Loop, %ActionCategory_Count%
	{
		if (key = ActionCategory%A_Index%_Key) {
			return A_Index
		}
	}
	return 0
}

;-------------------------------------------------------------------------------
; Add Action Script
;														Implemented by lukewarm
;														Modified by Pyonkichi
;-------------------------------------------------------------------------------
MG_AddActionScript(script, pos="")
{
	global
	script := ";" . ActionTitle%DDLActionCategory%_%DDLActionTemplate% . "`n" . script
	Gui, MEW_Main:Submit, NoHide
	if(pos="top"){
		EAction=%script%`n%EAction%
	}else{
		Join(EAction, script)
	}
	GuiControl, MEW_Main:, EAction, %EAction%
	MG_SaveModificationObj.("Modified", "EAction")
}

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;
;	Rendering Function of Gesture Patterns
;
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;-------------------------------------------------------------------------------
; Create Font
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_CreateFont(szFace, nSize, nWeight=0, nQuality=0)
{
	return DllCall("CreateFont"
					,"Int",-nSize							; nHeight
					,"Int",0								; nWidth
					,"Int",0								; nEscapement
					,"Int",0								; nOrientation
					,"Int",nWeight							; nWeight
					,"UInt",0								; fdwItalic
					,"UInt",0								; fdwUnderline
					,"UInt",0								; fdwStrikeOut
					,"UInt",(szFace="Wingdings" ? 2 : 1)	; fdwCharset
					,"UInt",0								; fdwOutPrecision
					,"UInt",0								; fdwClipPrecision
					,"UInt",nQuality						; fdwQuality
					,"UInt",0								; fdwPitchAndFamily
					,"Str",szFace							; pszFaceName
					,"Ptr")
}

;-------------------------------------------------------------------------------
; Draw Gesture Pattern
;														Implemented by Pyonkichi
;-------------------------------------------------------------------------------
MG_DrawGesture(hDC, ptX, ptY, szGesture, ByRef strW=0, ByRef strH=0, fMeasure=0, nGesLen=0)
{
	global MG_BtnNames, MG_AdNaviNI2, MG_hFntBtn, MG_hFntDir, MG_AdNaviSize
	static DirD=0xEA, DirL=0xE7, DirR=0xE8, DirU=0xE9
	static Dir1=0xED, Dir2=0xEA, Dir3=0xEE, Dir4=0xE7, Dir6=0xE8, Dir7=0xEB, Dir8=0xE9, Dir9=0xEC

	if (!fMeasure) {
		hRgn := DllCall("CreateRectRgn", "Int",ptX, "Int",ptY, "Int",ptX+strW, "Int",ptY+strH, "Ptr")
		DllCall("SelectClipRgn", "Ptr",hDC, "Ptr",hRgn)
	}
	DllCall("SetTextAlign", "Ptr",hDC, "Ptr",24)
	hFntOld := DllCall("SelectObject", "Ptr",hDC, "Ptr",MG_hFntBtn, "Ptr")
	VarSetCapacity(size, 8, 0)
	max:=StrLen(szGesture), pos:=1, preFont:=1, nowX:=ptX, strH:=0, sftBase:=MG_AdNaviSize//6
	while (pos <= max)
	{
		shift := 0
		if (SubStr(szGesture, pos, 1) == "_")
		{
			newFont := 1
			szDraw := "_"
			offset := 1
			shift := fDown ? 0 : (sftBase-MG_AdNaviSize)
			fDown := 0
		}
		else
		{
			fDown := 0
			Loop, Parse, MG_BtnNames, _
			{
				if (A_LoopField && InStr(SubStr(szGesture, pos), A_LoopField) == 1) {
					newFont := 1
					szDraw := A_LoopField
					offset := StrLen(A_LoopField)
					fDown := 1
					break
				}
			}
			if (!fDown) {
				newFont := 2
				dir := "Dir" . SubStr(szGesture, pos, 1)
				szDraw := Chr(%dir%)
				offset := 1
				shift := (dir="DirD"||dir="Dir2") ? sftBase : 0
			}
		}
		if (preFont != newFont) {
			preFont := newFont
			DllCall("SelectObject", "Ptr",hDC, "Ptr",(newFont==1 ? MG_hFntBtn : MG_hFntDir))
		}
		if (!fMeasure) {
			DllCall("TextOut", "Ptr",hDC, "Int",nowX, "Int",ptY+MG_AdNaviSize+shift, "Str",szDraw, "Int",StrLen(szDraw))
		}
		DllCall("GetTextExtentPoint32", "Ptr",hDC, "Str",szDraw, "Int",StrLen(szDraw), "Ptr",&size)
		nowX += NumGet(size, 0, "UInt")
		h := NumGet(size, 4, "UInt")
		if (h > strH) {
			strH := h
		}
		pos += offset
		if (pos == nGesLen+1) {
			DllCall("SetTextColor", "Ptr",hDC, "UInt",MG_AdNaviNI2)
		}
	}
	strW := nowX - ptX
	DllCall("SelectObject", "Ptr",hDC, "Ptr",hFntOld)
	DllCall("SetTextAlign", "Ptr",hDC, "Ptr",0)
	if (!fMeasure) {
		DllCall("SelectClipRgn", "Ptr",hDC, "Ptr",0)
		DllCall("DeleteObject", "Ptr",hRgn)
	}
}

MG_CommonLibEnd:
