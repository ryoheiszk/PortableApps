#Hotstring C O K-1 Z
; C : 大文字小文字の区別
; O : 最後に終了文字を入力しない
; Kn: キーの入力間隔を調整する
; Z : 発動時点でキー入力のバッファをクリアする
; R : 特殊キーをそのまま入力する(個別設定)

; 基本
::gia::git add .
::gibr::git branch{Space}
::gibrd::git branch -d{Space}
::gic::git commit -m ""{Left}
::gica::git commit --amend -m ""{Left}
::gican::git commit --amend --no-edit
::gico::git checkout{Space}
::gicob::git checkout -b{Space}
::gicon::git config --global{Space}
::gist::git stash save --include-untracked ""{Left}
::gistl::git stash list
; ::gistp::
;   tmp := ClipboardAll
;   Clipboard = git stash pop stash@{}
;   Send, %Clipboard%
;   ; Send, {Left}
;   Clipboard := tmp
;   tmp =
;   Return
:R:gistp::git stash pop stash@{}
::gists::git stash show
::gireb::git rebase{Space}
::girebi::git rebase -i HEAD~
::giref::git reflog -7
::giresh::git reset --hard{Space}
::gireshh::git reset --hard HEAD^
::gil::git log --oneline -5
::gim::git merge --no-ff{Space}
::gips::git push origin master
; ::gipl::
::gis::git status{Space}

; 応用
::gishbr::git show-branch | grep '*'
; :R:gishbr::git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'
::gigr::git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'
