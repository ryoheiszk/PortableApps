﻿#Hotstring *C Z
; C: 大文字小文字を区別する
; *: 終了文字無しで発動する
; Z : 発動時点でキー入力のバッファをクリアする
; R : 特殊キーをそのまま入力する(個別設定)

; 一般
::teststring::
  Send, It's test.
Return
