; 英数キー無効
vkF0::Return


; 無変換,F1 ;; 選択文字列でGoogle検索
vk1D & F1::
	ClipSaved := ClipboardAll
	Send, ^c
	ClipWait, 2
	Run,https://www.google.co.jp/search?q=%Clipboard%
	Clipboard := ClipSaved
	ClipSaved =
Return


; アプリケーションキー + 矢印 ;; 音量変更
	;単体押下の動作指定
	AppsKey::Send,{AppsKey}

	;App + 上 = ボリュームを上げる
	AppsKey & Up::Send,{Volume_Up 2}

	;App + 下 = ボリュームを下げる
	AppsKey & Down::Send,{Volume_Down 2}

	;App + 左 = ミュート
	AppsKey & Left::Send,{Volume_Mute}


; コピーしたらツールチップを表示
OnClipboardChange:
	ToolTip コピーしました。
       	SetTimer, RemoveToolTip, 200
Return


; タイムシフト録画したら保存フォルダを開く
	~!F10::Goto, ^!F9


; 録画の保存フォルダを開く
	^!F9::Run, F:\Videos\GeforceExperience


; 新しいブランクファイルを作成
^+!f::
; エクスプローラがアクティブでなければ中断
If (!WinActive("ahk_class CabinetWClass")) {
	MsgBox, エクスプローラがアクティブではありません
	Return
}

; 現在表示中のディレクトリ
nowDir := GetActiveExplorerPath()

; ファイルを生成(重複はなんかよくないらしい)
FileAppend, , %nowDir%\myFileMadeByAutoHotkey

sleep, 1000	; 環境依存

; 生成したファイルにフォーカスしてリネーム
Send, myFileMadeByAutoHotkey{F2}
Return


; カレントディレクトリのパスを取得
^+!p::Clipboard := GetActiveExplorerPath()


; 日付入力
^vkBB::
	FormatTime, dateStr, , yyyy-MM-dd
	Send, {vkF2}{vkF3}%dateStr%
Return


; シャットダウン時にCatMemoNoteを終了(未実装)
/*
	OnExit, ExitCatMemoNote
	Return

	ExitCatMemoNote:
		If (A_ExitReason = Shutdown) {

		}
	ExitApp
*/