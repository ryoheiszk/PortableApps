; OneNote, Excel
#If, WinActive("ahk_exe ONENOTE.EXE")
    OR WinActive("ahk_exe EXCEL.EXE")
  ; 無変換 + Shift + R ;; 文字を赤色にする
  +r::
    If(GetKeyState("vk1D", "P"))
    {
      Send, {Ctrl Up}{Alt}hf1{Down 7}{Left 4}{Enter}
    }
    Else
    {
      Send, R
    }
  Return

  ; 無変換 + Shift + B ;; 文字を黒色にする
  +b::
    If(GetKeyState("vk1D", "P"))
    {
      Send, {Ctrl Up}{Alt}hf1a
    }
    Else
    {
      Send, B
    }
  Return

  ; 無変換 + Shift + G ;; 文字を深緑色にする
  +g::
    If(GetKeyState("vk1D", "P"))
    {
      Send, {Ctrl Up}{Alt}hf1{Down 5}{Right 4}{Enter}
    }
    Else
    {
      Send, G
    }
  Return
#If


; OneNote
#If, WinActive("ahk_exe ONENOTE.EXE")
  ;上下キー
  vk1D & i::ControlSend, OneNote::DocumentCanvas1, {Blind}{Up}
  vk1D & k::ControlSend, OneNote::DocumentCanvas1, {Blind}{Down}
  vk1D & 8::ControlSend, OneNote::DocumentCanvas1, {Blind}{Up 4}
  vk1D & ,::ControlSend, OneNote::DocumentCanvas1, {Blind}{Down 4}
#If

; Netflix
#If, WinActive("Netflix")
  ~Right::
  ~Left::
    Send, {Space 2}
  Return
#If
