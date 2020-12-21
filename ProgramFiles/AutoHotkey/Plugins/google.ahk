vk1C & g::
  ; 多重起動エラー回避
  If (WinExist("google.ahk")) {
    Return
  }

  Gui, Add, Edit, vStr w380
  Gui, Add, Button, Default, Search
  Gui, Show, Center w400, google.ahk
  Send, {vkF2}
Return

ButtonSearch:
  Gui, Submit
  Run, https://www.google.co.jp/search?q=%Str%

2GuiEscape:
2GuiClose:
  Gui, Destroy
Return
