#Hotstring C O Z
; C: 大文字小文字を区別する
; O : 最後に終了文字を入力しない
; Z : 発動時点でキー入力のバッファをクリアする
; R : 特殊キーをそのまま入力する(個別設定)

; 一般
::teststring::
  Send, It's test.
Return

::192::
  Send, 192.168.1.
Return
