/*初期化--------------------------------
---------------------------------------
---------------------------------------
*/
#Persistent
#NoEnv
;#UseHook
Process, Priority,, High
SendMode, Input
SetTitleMatchMode, 2
SetKeyDelay, , 10
#MaxHotkeysPerInterval 100

; 共通変数↓
	allKeys := "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,vkBB,vkBA,vkBC,Space,Tab,Enter,BS,vkF3,vkF4,vk1D,vkF2,vkF0"
; 共通変数↑

; PluginsのInclude↓
	; MG_Plugin.ahkにプラグインをリスト化して、まとめてインクルード/////////////////////////////////
	if (SearchPlugins()) {
		Reload
	}
	#Include %A_ScriptDir%\IncludePlugins.ahk	; AutoExexuteここまで

	SearchPlugins()
	{
		; nowPluginNameに、Pluginsフォルダ内のAHKスクリプトを整形して改行区切りリストとして格納///////////
		nowPluginName := ""
		Loop, %A_ScriptDir%\Plugins\*.ahk
		{
			nowPluginName .= "#" . "Include %A_ScriptDir%\Plugins\" . A_LoopFileName . "`n"
		}
		if (nowPluginName == "") {
			return 0
		}
		; oldPluginNameに、現在のIncludePlugins.ahkの内容を格納/////////////////////////////////
		file := FileOpen(A_ScriptDir . "\IncludePlugins.ahk", "r `n", "CP932")
		if (file)
		{
			oldPluginName := file.Read(file.Length)
			file.Close
			if (oldPluginName == nowPluginName) {
				return 0
			}
		}
		; oldPluginNameをnowPluginNameに書き換える////////////////////////////////////////////
		file := FileOpen(A_ScriptDir . "\IncludePlugins.ahk", "w `n", "CP932")
		if (!file) {
			return 0
		}
		file.Write(nowPluginName)
		file.Close
		return 1
	}
; PluginsのInclude↑


/*共通サブルーチン---------------------------------
-----------------------------------------------
-----------------------------------------------
*/
; ツールチップ/////////////////////////////////
myToolTipFunction(str, delay)
{
	ToolTip, %str%
	SetTimer, RemoveToolTip, -%delay%
}


RemoveToolTip:
	ToolTip
Return


RemoveToolTipAll:
	SetTimer, RemoveToolTip, Off	; 保険
	Loop, 20
		ToolTip, , , , % A_Index
Return

;////////////////////////////////////////////
;カレントディレクトリ取得//////////////////////////
; 使用するときは、nowDir := GetActiveExplorerPath()のように。
GetActiveExplorerPath() {
    explorerHwnd := WinActive("ahk_class CabinetWClass")
    if (explorerHwnd)
    {
        for window in ComObjCreate("Shell.Application").Windows
        {
            if (window.hwnd==explorerHwnd)
                return window.Document.Folder.Self.Path
        }
    }
}


;////////////////////////////////////////////
;キー有効・無効/////////////////////////////////
allKeyDisable:
	Loop, PARSE, allKeys, `,
	Hotkey, %A_LoopField%, allKeyDisable_Label, On
Return


allKeyEnable:
	Loop, PARSE, allKeys, `,
	Hotkey, %A_LoopField%, allKeyDisable_Label, Off
Return


allKeyDisable_Label:
Return


;////////////////////////////////////////////
;キー送信量増加/////////////////////////////////
/*
keyAccel(vol)
{
num := 1

; コロンで加速
If (GetKeyState("vkBA", "P"))
	num += vol
Return num
}

vkBA::Return
vk1D & vkBA::Return
*/

;////////////////////////////////////////////
