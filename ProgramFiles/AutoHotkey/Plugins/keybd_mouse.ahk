keybd_mouse:
  ; キー設定///////////////////////////////////
  exit_this       := "r"      ; keybd_mouse終了

  mouse_up        := "e"      ; ↑
  mouse_down      := "d"      ; ↓
  mouse_left      := "s"      ; ←
  mouse_right     := "f"      ; →
  mouse_LB        := "j"      ; 左クリック
  mouse_RB        := "l"      ; 右クリック
  mouse_MB        := "vkBC"   ; 中クリック
  scroll_up       := "i"      ; 上スクロール
  scroll_down     := "k"      ; 下スクロール

  accel_key       := "o"      ; カーソル加速
  decel_key       := "vkBB"   ; カーソル減速

  default_speed   := 4        ; 規定のカーソル移動速度
  accel_vol       := 16       ; accelKey押下時のカーソル移動速度の増加量
  slow_vol        := 1        ; decel_key押下時のカーソル移動速度
  move_ratio      := 16/9     ; 縦横移動量倍率

  ;////////////////////////////////////////////

  hotkeys_define(keys_all, "disable_keys", "On")
  Hotkey, %exit_this%, toggle_keybd_mouse

  Gosub, toggle_keybd_mouse

  SetTimer, mouse_click_checker, 100

  While (toggle_keybd_mouse == true) {
    ; 速度設定///////////////////////////
    speed := default_speed
    move_X := 0
    move_Y := 0

    If (GetKeyState(accel_key, "P"))
      speed += accel_vol
    If (GetKeyState(decel_key, "P"))
      speed := slow_vol
    ;////////////////////////////////////

    ; 移動方向設定///////////////////////
    If (GetKeyState(mouse_up, "P"))
      move_Y += speed
    If (GetKeyState(mouse_down, "P"))
      move_Y += -speed
    If (GetKeyState(mouse_left, "P"))
      move_X += -speed * move_ratio
    If (GetKeyState(mouse_right, "P"))
      move_X += speed * move_ratio
    ;////////////////////////////////////

    ; 移動///////////////////////////////
    MouseMove, move_X, -move_Y, 0, R
    ; ///////////////////////////////////
  }

  SetTimer, mouse_click_checker, Off

  hotkeys_define(keys_all, "disable_keys", "Off")
  Hotkey, %exit_this%, toggle_keybd_mouse, Off
Return


;////////////////////////////////////////////
;サブルーチン////////////////////////////////
;////////////////////////////////////////////

; トグル/////////////////////////////////////
toggle_keybd_mouse:
  toggle_keybd_mouse := !toggle_keybd_mouse

  my_tooltip_function("マウスモード: " . (toggle_keybd_mouse == true ? "ON" : "OFF"), 1000)

  ; タスクバーの高さを取得
  WinGetPos, , , , taskbarHeight, ahk_class Shell_TrayWnd

  ; 右下にツールチップ
  CoordMode, ToolTip, Screen
  ToolTip, % "マウスモード: " . (toggle_keybd_mouse == true ? "ON" : "OFF")
      ,A_ScreenWidth, A_ScreenHeight - (taskbarHeight + 21), 2  ; ツールチップの高さ: 20
  CoordMode, ToolTip, Relative

  ; OFFにするならそのツールチップは指定時間後に削除
  If (toggle_keybd_mouse == false)
    SetTimer, remove_tooltip_all, -500
Return
;////////////////////////////////////////////


; マウス/////////////////////////////////////
mouse_click_checker:
  ; マウス/////////////////////////////
  keybd_mouse_click(mouse_LB, "L")
  keybd_mouse_click(mouse_MB, "M")
  keybd_mouse_click(mouse_RB, "R")
  keybd_mouse_scroll(scroll_up, "Up", accel_key, decel_key, accel_vol)
  keybd_mouse_scroll(scroll_down, "Down", accel_key, decel_key, accel_vol)
  ;////////////////////////////////////
Return


keybd_mouse_click(key, button) {
  ;引数について////////////////////////
  ;// key:= "j", button:= "L" の場合 //
  ;// j を押すと LButtonが送信される //
  ;////////////////////////////////////

  ; 変数%button%B_downの値を引き継ぐ
  ; %button%B_downは直前に押したか離したかを記録
  Global

  ; 上記変数を用いた連打対策///////////
  ; 押すとき
  If (GetKeyState(key, "P") == true) {
    If (%button%B_down != true) {
      Send, {Blind}{%button%Button Down}
      %button%B_down := true

      ; 押下したら一瞬カーソルを止める
      Sleep, 150
    }
  ; 離すとき
  } Else {
    If (%button%B_down == true) {
      Send, {Blind}{%button%Button Up}
      %button%B_down := false
    }
  }
  ;////////////////////////////////////
}


keybd_mouse_scroll(key, scroll, accel_key, decel_key, accel_vol) {
  While (GetKeyState(key, "P")) {
    ; スクロール中はカーソルを固定
    If (GetKeyState(key, "P"))
      Send, {Blind}{Wheel%scroll%}

    ; スクロール速度の設定
    scroll_wait := 100
    If (GetKeyState(accel_key, "P"))
      scroll_wait -= accel_vol * 5
    If (GetKeyState(decel_key, "P"))
      scroll_wait := 200

    Sleep, scroll_wait
  }
}
;////////////////////////////////////////////
