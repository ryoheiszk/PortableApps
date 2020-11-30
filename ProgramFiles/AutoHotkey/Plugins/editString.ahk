; 無変換 + 右HP ;; カーソル移動関係
	;↑
	vk1D & i::Send, {Blind}{Up}

	;↓
	vk1D & k::Send, {Blind}{Down}

	;←
	vk1D & j::Send, {Blind}{Left}

	;→
	vk1D & l::Send, {Blind}{Right}

	;↑↑↑↑
	vk1D & 8::
	vk1D & 9::
		Send, {Blind}{Up 4}
	Return

	;↓↓↓↓
	vk1D & ,::Send, {Blind}{Down 4}

	;→→→→
	vk1D & .::Send, {Blind}{Right 4}

	;←←←←
	vk1D & m::Send, {Blind}{Left 4}

	;Home
	vk1D & h::Send, {Blind}{Home}

	;End
	vk1D & vkBB::Send, {Blind}{End}


; 無変換 + u ;; F10(半角英数に変換)
	vk1D & u::Send, {F10}


; 無変換 + o ;; 無変換
	vk1D & o::Send, {vk1D}


; 無変換 + Space ;; Backspace
	vk1D & Space::Send, {Blind}{Backspace}
/*
	num := keyAccel(4)
	Send,{Blind}{Backspace %num%}
*/


;無変換 + / ;; Enter
	vk1D & /::Send, {Blind}{Enter}


; 無変換 + 変換 ;; Delete
	vk1D & vk1C::Send,{Blind}{Delete}


; 無変換 + Enter ;; 行挿入
	vk1D & Enter::
		if (GetKeyState("Ctrl", "P")) {
			Send, {Up}{End}{Enter}
		} else {
			Send, {End}{Enter}
		}
	Return


; 無変換 + ローマ字キー ;; 半角英数入力モード
	vk1D & vkF2::Send, {vkF2}{vkF3}


; 無変換 + 1 ;; F2(リネーム)
	vk1D & 1::Send, {F2}


; 無変換 + 矢印 ;; 矢印入力
 	vk1D & Up::Send, {vkF2}{vkF3}↑{vkF2}
 	vk1D & Down::Send, {vkF2}{vkF3}↓{vkF2}
 	vk1D & Left::Send, {vkF2}{vkF3}←{vkF2}
 	vk1D & Right::Send, {vkF2}{vkF3}→{vkF2}
