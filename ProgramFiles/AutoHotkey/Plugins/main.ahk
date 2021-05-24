; 英数キー無効
vkF0::Return

;デスクトップフォルダを開く
#e::Run, %A_Desktop%

; 音量変更
; 単体押下の動作指定
AppsKey::Send,{AppsKey}

; ボリュームを上げる
AppsKey & Up::Send,{Volume_Up 1}

; ボリュームを下げる
AppsKey & Down::Send,{Volume_Down 1}

; ミュート
AppsKey & Left::Send,{Volume_Mute}

; コピーしたらツールチップを表示
OnClipboardChange:
  my_tooltip_function("コピー", 300)
Return

; 上書き保存したらツールチップ表示
^s::
  Send, ^s
  my_tooltip_function("上書き保存", 300)
Return

; タイムシフト録画したら保存フォルダを開く
~!F10::Goto, ^!F10

; 録画の保存フォルダを開く
^!F10::Run, D:\Videos\GeforceExperience

; カレントディレクトリのパスを取得
^+!p::Clipboard := get_current_dir()

; 日付入力
^vkBB::
  FormatTime, dateStr, , yyyy-MM-dd
  Send, {vkF2}{vkF3}%dateStr%
Return
