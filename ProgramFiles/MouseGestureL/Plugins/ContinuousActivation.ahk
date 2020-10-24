
;===== 機能説明 ==========================================================================
;
;
;		かざぐるマウスの
;		"ジェスチャー中の左クリックで入力コマンドを連続実行"
;		機能の代替プラグイン(を目指してみた)
;		
;		＋連続発動と押し下げ発動と押し上げ発動を区別できるようにしてみた(多分できてる？)
;		RB_Lだけ設定してるなら連続発動
;		RB_LLB_(押し下げ発動)やRB_LLB__(押し上げ発動)も設定してるならそちらが優先という仕様(のはず)
;		RB_LB_やMBやX1Bなどは自分は使ってないのでちゃんと動くかわかりません、ごめん
;		
;		MGLの仕様でアクション設定してなくてもジェスチャー定義してるだけで
;		MGLのiniやconfigにラベルが存在してるので注意
;		
;		ただしこのままでは例えばRB_Lをボタンで連続発動した後に
;		右クリックを離すとRB_Lに設定したアクションがもう一度発動します
;		
;		MouseGestureL.ahk本体をテキストエディタなどで直接開いて
;		583行目(他に弄ってなければ)の
;		MG_Check()
;		を
;		
;		if (!ContinuousActivation) {
;			MG_Check()
;		}
;		ContinuousActivation := 0
;		
;		に置き換えると多重発動しなくなります
;		
;		左クリックではなくて中クリックやX1ボタンなどで連続実行したい人は
;		↓の設定のConButton,LButton::,LButton Up::の3箇所を変更してどうぞ
;
;
;===============================================================================

;----- ボタン設定	------------------------------------------------

ConButton := "LB"	; 左クリック
; ConButton := "MB"	; 中クリック
; ConButton := "X1B"	; X1ボタン
; ConButton := "X2B"	; X2ボタン

;-------------------------------------------------------------------------------
Goto, ContinuousActivation_End

;----- ホットキー設定	------------------------------------------------

#If (MG_Active)
LButton::ContinuousActivation()	; 左クリック押し下げ
LButton up::ContinuousActivationUp()	; 左クリック押し上げ
; MButton::ContinuousActivation()	; 中クリック
; MButton up::ContinuousActivationUp()	; 中クリック押し上げ
; X1Button::ContinuousActivation()
; X1Button up::ContinuousActivationUp()
; X2Button::ContinuousActivation()
; X2Button up::ContinuousActivationUp()
#If

;----- サブルーチン	------------------------------------------------

ContinuousActivation() {
	Global
	MG_TriggerCount++
	MG_CurTriggers := MG_CurTriggers . ConButton . "_"

	LabelGesture := "MG_Gesture_" . MG_Gesture
	SaveGes := MG_Gesture
	MG_Gesture := MG_Gesture . ConButton . "_"
	If (IsLabel(LabelGesture . ConButton . "_")) {
		; ボタンの押し下げジェスチャーが設定されてる時
		Func("MG_Check").()
	} Else If (IsLabel(LabelGesture . ConButton . "__")) {
		; ボタンの押し上げジェスチャーが設定されてる時
	} Else If (IsLabel(LabelGesture . "_")) {
		; ジェスチャーの連続発動
		Func("MG_Check").(SaveGes . "_")
		ContinuousActivation++
		MG_Gesture := SaveGes
	} Else {
		; 設定されてるジェスチャーがない時
		Func("MG_Check").()
	}
}

ContinuousActivationUp() {
	Global	
	MG_TriggerCount	:= (MG_TriggerCount>0) ? (MG_TriggerCount-1) : 0
	MG_CurTriggers	:= RegExReplace(MG_CurTriggers,"(?<=_|^)" . ConButton . "_")

	If (!ContinuousActivation) {
		; 押し上げジェスチャーがあれば発動する
		MG_Gesture := MG_Gesture . "_"
		LabelGesture := "MG_Gesture_" . MG_Gesture
		If (IsLabel(LabelGesture)) {
			Func("MG_Check").()
		}
	}
}

;-------------------------------------------------------------------------------
ContinuousActivation_End:
