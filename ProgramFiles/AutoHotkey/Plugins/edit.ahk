; カーソル移動
; ↑
vk1D & i::Send, {Blind}{Up}

; ↓
vk1D & k::Send, {Blind}{Down}

; ←
vk1D & j::Send, {Blind}{Left}

; →
vk1D & l::Send, {Blind}{Right}

; Home
vk1D & h::Send, {Blind}{Home}

; End
vk1D & vkBB::Send, {Blind}{End}

; ↑↑↑↑
vk1D & 8::Send, {Blind}{Up 4}

; ↓↓↓↓
vk1D & ,::Send, {Blind}{Down 4}

; →→→→
vk1D & .::Send, {Blind}{Right 4}

; ←←←←
vk1D & m::Send, {Blind}{Left 4}

; F10(半角英数)
vk1D & u::Send, {F10}

; 無変換
vk1D & o::Send, {vk1D}

; Backspace
vk1D & Space::Send, {Blind}{Backspace}
vk1D & n::Send, {Blind}{Backspace}

; Delete
vk1D & vk1C::Send,{Blind}{Delete}
vk1D & /::Send,{Blind}{Delete}

; 行挿入
vk1D & Enter::
  if (GetKeyState("Ctrl", "P")) {
    Send, {Up}{End}{Enter}
  } else {
    Send, {End}{Enter}
  }
Return

; 半角英数
vk1D & vkF2::Send, {vkF2}{vkF3}

; F2
vk1D & 1::Send, {F2}

; 矢印入力
  vk1D & Up::Send, {vkF2}{vkF3}↑{vkF2}
  vk1D & Down::Send, {vkF2}{vkF3}↓{vkF2}
  vk1D & Left::Send, {vkF2}{vkF3}←{vkF2}
  vk1D & Right::Send, {vkF2}{vkF3}→{vkF2}
