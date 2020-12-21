vk1C & m::
  ; キー設定///////////////////////////////////
  hotKeyL       := "vk1C"   ; トリガー1
  hotKeyR       := "m"      ; トリガー2

  mouseUp       := "e"      ; ↑
  mouseDown     := "d"      ; ↓
  mouseLeft     := "s"      ; ←
  mouseRight    := "f"      ; →
  mouseLB       := "j"      ; 左クリック
  mouseRB       := "l"      ; 右クリック
  mouseMB       := "vkBC"   ; 中クリック
  scrollUp      := "i"      ; 上スクロール
  scrollDown    := "k"      ; 下スクロール

  accelKey1     := "o"      ; カーソル加速
  accelKey2     := "vkBB"   ; カーソル加速
  slowKey       := "vk1C"   ; カーソル減速

  defSpeed      := 4        ; 規定のカーソル移動速度
  accelVol      := 8        ; accelKey押下時のカーソル移動速度の増加量
  slowVol       := 1        ; slowKey押下時のカーソル移動速度
  moveRatio     := 16 / 9   ; 縦横移動量倍率

  chaseToolTip  := false    ; ツールチップの有効/無効

  ;////////////////////////////////////////////

  KeyWait, %hotKeyL%
  KeyWait, %hotKeyR%

  GoSub, allKeyEnable  ; これをかませてホットキーを存在させる
  GoSub, allKeyDisable  ; 上で定義されたホットキーを有効にする
  GoSub, toggle_KeyMouse  ; 操作モードをトグルする

  SetTimer, toggleCheck, 100      ; トグル状態をチェック
  SetTimer, mouseClickChecker, 50      ; マウスクリックをチェック
  if (chaseToolTip <> false)
    SetTimer, mouseToolTipMaker, 20    ; ツールチップを追跡させる

  While (toggle_KeyMouse = true) {
    ; 速度設定///////////////////////////
    speed := defSpeed
    moveX := 0
    moveY := 0

    if (GetKeyState(accelKey1, "P"))
      speed += accelVol    ; 加速
    if (GetKeyState(accelKey2, "P"))
      speed += accelVol    ; 加速
    if (GetKeyState(slowKey, "P"))
      speed := slowVol    ; 低速
    ;////////////////////////////////////

    ; 移動方向設定///////////////////////
    if (GetKeyState(mouseUp, "P"))
      moveY += speed
    if (GetKeyState(mouseDown, "P"))
      moveY += -speed
    if (GetKeyState(mouseLeft, "P"))
      moveX += -speed * moveRatio
    if (GetKeyState(mouseRight, "P"))
      moveX += speed * moveRatio
    ;////////////////////////////////////

    ; 移動///////////////////////////////
    MouseMove, moveX, -moveY, 0, R
    ; ///////////////////////////////////
  }

  GoSub, allKeyEnable

  SetTimer, mouseToolTipMaker, Off
  SetTimer, toggleCheck, Off
  SetTimer, mouseClickChecker, Off
  SetTimer, remove_tooltip_all, -500
Return


;////////////////////////////////////////////
;サブルーチン////////////////////////////////
;////////////////////////////////////////////

; トグル/////////////////////////////////////
toggleCheck:
  if (GetKeyState(hotKeyL, "P") AND GetKeyState(hotKeyR, "P")) {
    KeyWait, %hotKeyL%
    KeyWait, %hotKeyR%

    ; 操作モードをトグルする
    GoSub, toggle_KeyMouse
  }
Return

toggle_KeyMouse:
  toggle_KeyMouse := !toggle_KeyMouse

  my_tooltip_function("マウスモード: " . (toggle_KeyMouse = true ? "ON" : "OFF"), 1000)

  ; タスクバーの高さを取得
  WinGetPos, , , , taskbarHeight, ahk_class Shell_TrayWnd

  ; 右下にツールチップ
  CoordMode, ToolTip, Screen
  ToolTip, % "マウスモード: " . (toggle_KeyMouse = true ? "ON" : "OFF")
      ,A_ScreenWidth, A_ScreenHeight - (taskbarHeight + 21), 2  ; ツールチップの高さ: 20
  CoordMode, ToolTip, Relative
Return
;////////////////////////////////////////////


; マウス/////////////////////////////////////
mouseClickChecker:
  ; マウス/////////////////////////////
  KeyMouseClick(mouseLB, "L")
  KeyMouseClick(mouseMB, "M")
  KeyMouseClick(mouseRB, "R")
  KeyMouseScroll(scrollUp, "Up", accelKey1, accelKey2, slowKey, accelVol)
  KeyMouseScroll(scrollDown, "Down", accelKey1, accelKey2, slowKey, accelVol)
  ;////////////////////////////////////
Return


KeyMouseClick(key, button) {
  ;引数について////////////////////////
  ;// key:= "j", button:= "L" の場合 //
  ;// j を押すと LButtonが送信される //
  ;////////////////////////////////////

  ; 変数%button%B_downの値を引き継ぐ
  ; %button%B_downは直前に押したか離したかを記録
  Global

  ; 上記変数を用いた連打対策///////////
  if (GetKeyState(key, "P") = true) {
    ;押すとき
    if (%button%B_down != true) {
      Send, {Blind}{%button%Button Down}
      %button%B_down := true

      ; 押下したら一瞬カーソルを止める
      Sleep, 150
    }
  } else {  ;離すとき
    if (%button%B_down = true) {
      Send, {Blind}{%button%Button Up}
      %button%B_down := false
    }
  }
  ;////////////////////////////////////
}


KeyMouseScroll(key, scroll, accelKey1, accelKey2, slowKey, accelVol) {
  While (GetKeyState(key, "P")) {
    ; スクロール中はカーソルを固定
    if (GetKeyState(key, "P"))
      Send, {Blind}{Wheel%scroll%}

    ; スクロール速度の設定
    scrollWait := 100
    if (GetKeyState(accelKey1, "P"))
      scrollWait -= accelVol * 5
    if (GetKeyState(accelKey2, "P"))
      scrollWait -= accelVol * 5
    if (GetKeyState(slowKey, "P"))
      scrollWait := 200

    Sleep, scrollWait
  }
}


mouseToolTipMaker:
  ToolTip, マウスモード: ON
Return
;////////////////////////////////////////////
