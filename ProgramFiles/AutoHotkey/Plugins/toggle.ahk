vk1C::Send, {vk1C}

;==============================
#If, toggle_KeyMouse != true


vk1C & a::toggleChange(toggle_a, "AHK")
vk1C & p::toggleChange(toggle_p, "プログラミング")
vk1C & e::toggleChange(toggle_e, "Edit")


#If


toggleChange(ByRef toggle, name)
{
	toggle := !toggle
	myToolTipFunction("カスタムモード(" . name . "): " . (toggle = true ? "ON" : "OFF"), 1000)

	CoordMode, ToolTip, Screen
	ToolTip, % (toggle = true ?  "カスタムモード(" . name . "): ON" : ""), 0, 0, 20
	CoordMode, ToolTip, Relative
}


;==============================
; AutoHotkey///////////////////

#If, toggle_a = true


; AHKを閉じる
e::
	Run, taskkill /F /IM MouseGestureL.exe, , Hide
	ExitApp

Return


; AHKをリロード
r::Reload


; 実行ファイルのフォルダを開く
o::
	Run, %A_ScriptDir%
	toggleChange(toggle_a, "AHK")
Return


; AHKWiki(日本語)を開く
h::
	Run, http://ahkwiki.net/Top
	toggleChange(toggle_a, "AHK")
Return


; WindowSpyを開く
w::
	Run, %A_ScriptDir%\AutoHotkey.exe %A_ScriptDir%\WindowSpy.ahk
	toggleChange(toggle_a, "AHK")
Return


#If

;==============================

; プログラミング///////////////

#If, toggle_p = true


; javaコンパイルの定型文
j::
	Send, {vkF2}{vkF3}javac -encoding utf-8 .java{Left 5}
	toggleChange(toggle_p, "プログラミング")
Return

; C言語コンパイルの定型文
c::
	Send, {vkF2}{vkF3}gcc -o a .c{Left 2}
	toggleChange(toggle_p, "プログラミング")
Return


#If

;==============================
; 編集/////////////////////////

#If, toggle_e = true


; 1行コピー
c::
	Send, {Home}+{End}^c{Right}
	toggleChange(toggle_e, "Edit")
Return


; 1行挿入
l::
	Send, {Home}{Enter}{Up}
	toggleChange(toggle_e, "Edit")
Return


; 1行削除
e::
	Send, {End}+{Home}{Delete}
	toggleChange(toggle_e, "Edit")
Return


; キャレット以下1行削除
Delete::
	Send, +{End}{Delete}
	toggleChange(toggle_e, "Edit")
Return


; キャレット以前1行削除
Backspace::
	Send, +{Home}{Backspace}
	toggleChange(toggle_e, "Edit")
Return


#If

;==============================
