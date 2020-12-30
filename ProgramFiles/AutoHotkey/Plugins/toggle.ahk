; ReadMe////////////////////
; 使用時:
;   1. トリガーキー(変換)+プライマリキー
;   2. セカンダリキー
;
; トリガー追加時:
;   1. プライマリキーセクションにキーを追加
;   2. セカンダリキー設定
;
; 課題:
;   ・プライマリキー指定を一括化
;   ・未定義の場合その旨を表示
;   ・プライマリキーとセカンダリキーが同じ場合、A_ThisHotkeyに変化がないためtoggleをfalseにできない
;     現状はセカンダリキーの方で明示的にfalseにしている(例: vk1C+e->e)


; 修飾キー単体動作の定義////////////////////
vk1C::Send, {vk1C}

; プライマリキー////////////////////
#If, GetKeyState("vk1C", "P") == true
  a::
  b::
  c::
  d::
  e::
  f::
  g::
  h::
  i::
  j::
  k::
  l::
  m::
  n::
  o::
  p::
  q::
  r::
  s::
  t::
  u::
  v::
  w::
  x::
  y::
  z::
    ; keybdmouseが有効の場合toggleしない
    If (toggle_KeyMouse) {
      Return
    }

    toggle := A_ThisHotkey
    toggle_activation(toggle)
    SetTimer, watch_hotkey_done, 50

    GoSub, allKeyDisable
  Return
#If

; セカンダリキー////////////////////
; 入力キャンセル
#If, toggle != false
  Esc::SetTimer, toggle_deactivation, Off
#If

; AutoHotkey
#If, toggle == "a"
  ; リロード
  r::Reload

  ; 実行ファイルのフォルダを開く
  o::Run, %A_ScriptDir%

  ; Wiki(日本語)を開く
  h::Run, http://ahkwiki.net/Top

  ; WindowSpy
  w::Run, %A_ScriptDir%\AutoHotkey.exe %A_ScriptDir%\WindowSpy.ahk

; (空き)
#If, toggle == "b"
; (空き)
#If, toggle == "c"
; (空き)
#If, toggle == "d"
; 文字編集
#If, toggle == "e"
  ; 1行コピー
  c::Send, {Home}+{End}^c{Right}

  ; 1行削除
  e::
    Send, {End}+{Home}{Delete}
    Goto, toggle_deactivation
  Return

  ; 1行削除(キャレット～末尾)
  Delete::Send, +{End}{Delete}

  ; 1行削除(先頭～キャレット)
  Backspace::Send, +{Home}{Backspace}

; (空き)
#If, toggle == "f"
; GUI
#If, toggle == "g"
  ; Google検索
  g::
    ; (「課題」参照)
    Gosub, toggle_deactivation
    ; 多重起動防止
    If (WinExist("google.ahk")) {
      Return
    }
    ; GUI表示
    Gui, Add, Edit, vStr w380
    Gui, Add, Button, Default, Search
    Gui, Show, Center w400, google.ahk
    Send, {vkF2}
    Return
    ButtonSearch:
      Gui, Submit
      Run, https://www.google.co.jp/search?q=%Str%
    2GuiEscape:
    2GuiClose:
      Gui, Destroy
  Return

  ; launcher
  l::
    ; 多重起動防止
    If (WinExist("Launcher")) {
      Return
    }
    launcher_head:
    Gui, Add, Edit, vStr Lowercase
    Gui, Add, Button, Default, Launch
    Gui, Show, Center AutoSize, Launcher
    Send, {vkF2}{vkF3}
    Return
    ButtonLaunch:
      Gui, Submit
      IniRead, val, %A_ScriptDir%\Plugins\launcher_data.ini, Scripts, %Str%
      ; 一致するレコードがなければval="ERROR"となることを利用する
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

; (空き)
#If, toggle == "h"
; (空き)
#If, toggle == "i"
; (空き)
#If, toggle == "j"
; (空き)
#If, toggle == "k"
; (空き)
#If, toggle == "l"
; (空き)
#If, toggle == "m"
; (空き)
#If, toggle == "n"
; (空き)
#If, toggle == "o"
; プログラミング
#If, toggle == "p"
  ; C言語コンパイル
  c::Send, {vkF2}{vkF3}gcc -o a .c{Left 2}

  ; Javaコンパイル
  j::Send, {vkF2}{vkF3}javac -encoding utf-8 .java{Left 5}

; (空き)
#If, toggle == "q"
; (空き)
#If, toggle == "r"
; (空き)
#If, toggle == "s"
; (空き)
#If, toggle == "t"
; (空き)
#If, toggle == "u"
; (空き)
#If, toggle == "v"
; (空き)
#If, toggle == "w"
; (空き)
#If, toggle == "x"
; (空き)
#If, toggle == "y"
; (空き)
#If, toggle == "z"
#If


; サブルーチン////////////////////
; セカンダリキー入力待ちにし、タイムアウトをSetTimerする
toggle_activation(toggle) {
  time_limitation := 2000
  SetTimer, toggle_deactivation, -%time_limitation%
  my_tooltip_function("vk1C + " . toggle . " -> ?", time_limitation)
}

toggle_deactivation:
  toggle := false
  my_tooltip_function("toggle == false", 1000)
  GoSub, allKeyEnable
Return

; セカンダリキーの入力があった場合、toggleをfalseにし、SetTimerしたタイムアウト設定を解除する
watch_hotkey_done:
  new_ThisHotkey := A_ThisHotkey

  ; toggleにはプライマリキー送信時のA_ThisHotkeyが格納されている
  ; 何らかのホットキー(つまりセカンダリキー)が実行されたとき、A_ThisHotkeyが書き換わることを利用する
  If (new_ThisHotkey != toggle) {
    SetTimer, toggle_deactivation, Off
    SetTimer, watch_hotkey_done, Off
    Goto, toggle_deactivation
  }
Return
