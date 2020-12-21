; ReadMe////////////////////
; 使用時:
;   1. 無変換+トリガー
;   2. キー入力
;
; トリガー追加時:
;   1. トリガー有効化
;   2. 個別設定追加
;
; 課題:
;   ・トリガー有効化を一括化したい
;   ・Goto, toggle_deactivationの繰り返しがダサい


; 修飾キー単体動作の定義////////////////////
vk1C::Send, {vk1C}

; トリガー有効化////////////////////
#If GetKeyState("vk1C", "P") == true
  a::
  e::
  p::
    toggle := A_ThisHotkey
    toggle_activation(toggle)
  Return
#If

#If toggle != false
  Esc::Goto, toggle_deactivation
#If


; 個別設定////////////////////
; AutoHotkey
#If toggle == "a"
  ; 閉じる
  ; e::
  ;   Run, taskkill /F /IM MouseGestureL.exe, , Hide
  ;   ExitApp
  ; Return

  ; リロード
  r::Reload

  ; 実行ファイルのフォルダを開く
  o::
    Run, %A_ScriptDir%
    Goto, toggle_deactivation
  Return

  ; Wiki(日本語)を開く
  h::
    Run, http://ahkwiki.net/Top
    Goto, toggle_deactivation
  Return

  ; WindowSpy
  w::
    Run, %A_ScriptDir%\AutoHotkey.exe %A_ScriptDir%\WindowSpy.ahk
    Goto, toggle_deactivation
  Return

#If toggle == "p"
  ; Javaコンパイル
  j::
    Send, {vkF2}{vkF3}javac -encoding utf-8 .java{Left 5}
    Goto, toggle_deactivation
  Return

  ; C言語コンパイル
  c::
    Send, {vkF2}{vkF3}gcc -o a .c{Left 2}
    Goto, toggle_deactivation
  Return

#If toggle == "e"
  ; 1行コピー
  c::
    Send, {Home}+{End}^c{Right}
    Goto, toggle_deactivation
  Return

  ; 1行削除
  e::
    Send, {End}+{Home}{Delete}
    Goto, toggle_deactivation
  Return

  ; 1行削除(キャレット～末尾)
  Delete::
    Send, +{End}{Delete}
    Goto, toggle_deactivation
  Return

  ; 1行削除(先頭～キャレット)
  Backspace::
    Send, +{Home}{Backspace}
    Goto, toggle_deactivation
  Return
#If

; サブルーチン////////////////////
toggle_activation(toggle) {
  time_limitation := 2000
  SetTimer, toggle_deactivation, -%time_limitation%
  my_tooltip_function("vk1C + " . toggle . " -> ?", time_limitation)
}

toggle_deactivation:
  toggle := false
  my_tooltip_function("toggle == false", 1000)

  ; 手動で無効化した場合、遅れて発動するタイマーを停止
  SetTimer, toggle_deactivation, Off
Return
