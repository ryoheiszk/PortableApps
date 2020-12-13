#Hotstring C O Kn Z
; C : 大文字小文字の区別
; O : 最後に終了文字を入力しない
; Kn: キーの入力間隔を最速にする
; Z : 発動時点でキー入力のバッファをクリアする
; R : 特殊キーをそのまま入力する(個別設定)


; 基本
::gia::git add .
::gibr::git branch{Space}
::gic::git commit -m ""{Left}
::gico::git checkout{Space}
::gicon::git config --global{Space}
::gires::git reset --hard HEAD^
::gil::git log --oneline -5
::gim::git merge{Space}
::gips::git push origin master
; ::gipl::
::gis::git status{Space}

; 応用
:R:gishbr::git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'
::gigr::git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'
