; Shift + 0 ;; ()
  +0::Send, {vkF2}{vkF3}+8+9{Left}

set_brackets(bracket_open, bracket_close) {
  stash := ClipboardAll
  Clipboard := ""
  Send, ^c
  ClipWait,1
  clip_copied := Clipboard
  ; キャレットが行頭にある場合、改行コードが格納される
  Send, +{Left}^c
  ClipWait,1
  clip_backward := Clipboard
  ; 文字選択状態の判定用
  length_clip_copied := StrLen(clip_copied)
  length_clip_backward := StrLen(clip_backward)
  ; 行頭だったら選択状態を戻す(未選択時の1行コピー防止)
  if (clip_backward == "`r`n" || clip_backward == "`r" || clip_backward == "`n") {
    Send, +{Right}
    clip_backward := ""
  ; 文書頭の場合
  } else if (clip_backward == clip_copied && length_clip_backward == length_clip_copied) {
    clip_backward := clip_copied
  ; 行頭かもしれない場合(1つ戻って改行コードを選択したかもしれない場合)
  } else if (length_clip_backward == 1) {
    ; 行頭ではなく、2文字の選択だった場合(1つ戻って1文字の選択となるため、直接は改行コードとの区別ができない)
    if (length_clip_copied == 2 && SubStr(clip_copied, 2, 1) != "`r" && SubStr(clip_copied, 2, 1) != "`n") {
      Send, +{Right}
      clip_backward := clip_copied
    ; 行頭だった場合
    } else {
      Send, +{Right}
      clip_backward := ""
    }
  ;
  } else if (length_clip_copied - length_clip_backward > 2 && length_clip_backward != 0) {
    Send, +^{Right}
    clip_backward := clip_copied
  ; 文書頭かつ無選択の場合
  } else if (length_clip_backward == 0 && length_clip_copied != 1) {
    clip_backward := ""
  ;
  } else {
    Send, +{Right}
    clip_backward := clip_copied
  }
  Clipboard := bracket_open . clip_backward . bracket_close
  Sleep, 50
  Send, ^v{left}
  Clipboard := stash
  stash := ""
}

vk1D & [::
  if (GetKeyState("Shift", "P") && GetKeyState("Ctrl", "P")) {
    set_brackets("「", "」")
  } else if (GetKeyState("Ctrl", "P")) {
    set_brackets("{", "}")
  } else if (GetKeyState("Shift", "P")) {
    set_brackets("[", "]")
  } else {
    set_brackets("(", ")")
  }
Return

vk1D & ]::
  set_brackets("""", """")
Return
