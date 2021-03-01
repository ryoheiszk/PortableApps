;===============================================================================
;
;		MouseGestureL.ahk 拡張スクリプト
;
;		・起動時の初期化処理や、ジェスチャー実行時に呼び出されるサブルーチン、
;		　関数などを定義できます。
;		・設定画面内の各種リストのサイズなども変更できます。
;		・内容を書き換えた場合はスクリプトをリロードしてください。
;
;===============================================================================

;----- ユーザー定義の初期化処理	------------------------------------------------
if (!MG_IsEdit) {
; MouseGestureL.ahk用

	ControlGetText, mouseToolTip, , ahk_class tooltips_class32

} else {
; MG_Edit.ahk用

	; ClassNNが一致したときにジェスチャーを無効化するための関数
	; 無変換押下時は作動しない
	; 「無効にする」=「Return 1」
	; ジェスチェー無効→カスタム条件式→compareClassNN("class_nn")で指定する
	; 例えばXMindのマッピングエリアではジェスチャーを基本無効にする
	compareClassNN(set_class_nn) {
		MouseGetPos, , , , got_class_nn

		If (GetKeyState("vk1D", "P")) {
			Return 0
		}

		If (set_class_nn==got_class_nn) {
			Return 1
		}

		Return 0
	}

}
; MouseGestureL.ahk、MG_Edit.ahk共通






;-------------------------------------------------------------------------------
Goto, MG_User_End

;----- ユーザー定義サブルーチン	------------------------------------------------
;******↓ツールチップ関数↓******
myToolTipFunction(str, delay)
{
	ToolTip %str%
	SetTimer, RemoveToolTip, -%delay%
}

;******↑ツールチップ関数↑******

;******↓マウス移動量関数↓******
myMouseMove(s)
{
	CoordMode,Mouse,Screen 			;絶対座標を指定
	MouseGetPos, oldX, oldY			;始点の座標取得
	Sleep, s 				;マウス移動時間
	MouseGetPos, newX, NewY			;終点の座標取得

	;xの変位+yの変位を返す
	Return (Abs(oldX - NewX) + Abs(oldY - NewY))
}

;******↑マウス移動量関数↑******

;******共通******
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip,
	Return

;-------------------------------------------------------------------------------
MG_User_End:
