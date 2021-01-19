#Hotstring C O Z
; C : 大文字小文字の区別
; O : 最後に終了文字を入力しない
; Z : 発動時点でキー入力のバッファをクリアする
; R : 特殊キーをそのまま入力する(個別設定)

; 基本
::gia::git add .
::giac::git commit -a -m ""{Left}
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
:R:gistp::git stash pop stash@{}
::gists::git stash show
::gireb::git rebase{Space}
::girebi::git rebase -i HEAD~
::giref::git reflog -7
::giress::git reset --soft HEAD
::giresh::git reset --hard HEAD
::gil::git log --oneline -5
::gim::git merge --no-ff{Space}
::gis::git status{Space}

; 応用
::gishbr::git show-branch | grep '*'
; :R:gishbr::git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'
::gigr::git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'

; Hugo(一時保存場所)
::hugoserver::hugo server -D --ignoreCache