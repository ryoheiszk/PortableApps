vk1C & vk1D::
; 多重起動エラー回避
If (WinExist("Launcher")) {
  Return
}

; 先頭ラベル(繰り返し処理用)
launcher_head:

Gui, Add, Edit, vStr Lowercase
Gui, Add, Button, Default, Launch
Gui, Show, Center AutoSize, Launcher
Send, {vkF2}{vkF3}
Return


ButtonLaunch:
Gui, Submit  ;変数Strをコントロール下に
IniRead, val, %A_ScriptDir%\Plugins\launcher.ini, Scripts, %Str%

; 一致するエントリがなければval="ERROR"となることを利用する
If (val != "ERROR") {
  Run, %val%
} Else {
  GoSub, GuiClose
  Goto, launcher_head
}

GuiEscape:
GuiClose:
Gui, Destroy
Return