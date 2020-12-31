#Persistent
#NoEnv
#UseHook
#MaxHotkeysPerInterval, 100
Process, Priority,, High
SendMode, Input
SetTitleMatchMode, 2
SetKeyDelay, , 10

; 変数の初期化
#Include, %A_ScriptDir%\Variables.ahk

; プラグインの検出・取り込み
if (search_plugins()) {
  Reload
}

search_plugins() {
  ; Pluginsフォルダ内のAHKスクリプト名を整形してpluginsに格納
  plugins := ""
  Loop, %A_ScriptDir%\Plugins\*.ahk {
    plugins .= "#" . "Include *i %A_ScriptDir%\Plugins\" . A_LoopFileName . "`n"
  }
  if (plugins == "") {
    return 0
  }

  ; Pluginsの変更点を認識
  file := FileOpen(A_ScriptDir . "\PluginList.ahk", "r `n", "CP932")
  if (file) {
    plugin_list_old := file.Read(file.Length)
    file.Close
    if (plugin_list_old == plugins) {
      return 0
    }
  }

  ; plugin_list_oldをpluginsに書き換える
  file := FileOpen(A_ScriptDir . "\PluginList.ahk", "w `n", "CP932")
  if (!file) {
    return 0
  }
  file.Write(plugins)
  file.Close
  return 1
}

; (AutoExexuteここまで)

#Include, %A_ScriptDir%\PluginList.ahk

; 共通サブルーチン
; ツールチップ
my_tooltip_function(str, delay) {
  ToolTip, %str%
  SetTimer, remove_tooltip, -%delay%
}

remove_tooltip:
  ToolTip
Return

remove_tooltip_all:
  SetTimer, remove_tooltip, Off
  Loop, 20
  ToolTip, , , , % A_Index
Return

;カレントディレクトリ取得
get_current_dir() {
  explorerHwnd := WinActive("ahk_class CabinetWClass")
  if (explorerHwnd) {
    for window in ComObjCreate("Shell.Application").Windows {
      if (window.hwnd==explorerHwnd)
      return window.Document.Folder.Self.Path
    }
  }
}

;キー有効・無効
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

; 改行コード除去
cut_crlf(str) {
  str := RegExReplace(str, "\n", "")
  str := RegExReplace(str, "\r", "")
  Return str
}

GuiEscape:
GuiClose:
  Gui, Destroy
Return