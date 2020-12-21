; 英数キー無効
vkF0::Return

;デスクトップフォルダを開く
#e::Run, %A_Desktop%

; 選択文字列でGoogle検索
vk1D & F1::
  ClipSaved := ClipboardAll
  Send, ^c
  ClipWait, 2
  Run,https://www.google.co.jp/search?q=%Clipboard%
  Clipboard := ClipSaved
  ClipSaved =
Return

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
  ToolTip コピーしました。
  SetTimer, remove_tooltip, 200
Return

; タイムシフト録画したら保存フォルダを開く
~!F10::Goto, ^!F9

; 録画の保存フォルダを開く
^!F9::Run, F:\Videos\GeforceExperience

; カレントディレクトリのパスを取得
^+!p::Clipboard := get_current_dir()

; 日付入力
^vkBB::
  FormatTime, dateStr, , yyyy-MM-dd
  Send, {vkF2}{vkF3}%dateStr%
Return

; 新しいブランクファイルを作成
^+!f::
  ; エクスプローラがアクティブでなければ中断
  If (!WinActive("ahk_class CabinetWClass")) {
    MsgBox, エクスプローラがアクティブではありません
    Return
  }
  ; 現在表示中のディレクトリ
  current_dir := get_current_dir()
  ; ファイルを生成(重複しない名前)
  Gui, Add, Edit, vStr w380
  Gui, Add, Button, Default, Append
  Gui, Show, Center w400, ファイル名
  Send, {vkF2}{vkF3}
Return
ButtonAppend:
  Gui, Submit
  FileAppend, , %current_dir%\%Str%
3GuiEscape:
3GuiClose:
  Gui, Destroy
Return