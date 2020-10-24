'===============================================================================
'
'		MouseGestureL.ahk Setup Script
'
'																	   Pyonkichi
'===============================================================================
Option Explicit

Const strMGL = "MouseGestureL.exe"
Const strAHK = "AutoHotkey.exe"
Dim strCap, strMsg1, strMsg2, strMsg3, strZip, strURL

Call SetLanguage
if MsgBox(strMsg1, 1, strCap)=1 then
	Call SetupMGL
end if

Sub SetLanguage()
	if GetLocale()=1041 then
		strCap	= "MouseGestureL.ahkのインストール"
		strMsg1	= "AutoHotkeyをダウンロードします。" & vbCrLf & "既にAutoHotkeyがインストールされている場合はキャンセルしてください。"
		strMsg2	= "ダウンロード中・・・"
		strMsg3	= "エラーが発生しました。" & vbCrLf & "手動でインストールしてください。"
	else
		strCap	= "MouseGestureL.ahk Setup"
		strMsg1	= "This will download the AutoHotkey." & vbCrLf & "If AutoHotkey is already installed, cancel this."
		strMsg2	= "Downloading..."
		strMsg3	= "An error has occurred." & vbCrLf & "Please install manually."
	end if
End Sub

Sub SetupMGL()
	if CheckOSArchitecture()=True then
		strZip = "ahk-u64.zip"
	else
		strZip = "ahk-u32.zip"
	end if
	strURL = "http://ahkscript.org/download/" + strZip

	Dim objHtml
	Set objHtml=CreateObject("htmlfile")
	objHtml.parentWindow.setTimeout GetRef("GetAHK"), 100
	MsgBox strMsg2, 0, strCap
	Set objHtml = Nothing
End Sub

Function CheckOSArchitecture()
	CheckOSArchitecture = False

	On Error Resume Next
	Dim objLocator, objServer, objClasses, objClass, strOS
	Set objLocator = WScript.CreateObject("WbemScripting.SWbemLocator")
	Set objServer = WScript.CreateObject("WbemScripting.SWbemLocator").ConnectServer
	Set objClasses = objServer.ExecQuery("Select * From Win32_OperatingSystem")
	strOS = ""
	For Each objClass In objClasses
		strOS = CStr(objClass.OSArchitecture)
		if Left(strOS, 2)="64" then CheckOSArchitecture = True
	Next
	Set objLocator = Nothing
	Set objServer = Nothing
	Set objClasses = Nothing
	Set objClass = Nothing
End Function

Sub GetAHK()
	'Get Script Folder Name
	Dim objFileSys, strFolder
	Set objFileSys = CreateObject("Scripting.FileSystemObject")
	strFolder = objFileSys.GetParentFolderName(WScript.ScriptFullName) + "\"

	'Download Zipped AHK
	Dim objSrvHTTP
	Set objSrvHTTP = CreateObject("Msxml2.ServerXMLHTTP.6.0")
	Call objSrvHTTP.Open("GET", strURL, False)
	objSrvHTTP.Send
	if objSrvHTTP.status >= 400 then
		MsgBox strMsg3, 16, strCap
		WScript.Timeout=1
		Exit Sub
	end if

	'Save to File
	Dim objStream
	Set objStream = CreateObject("ADODB.Stream")
	objStream.Open
	objStream.Type = 1
	objStream.Write objSrvHTTP.responseBody
	objStream.SaveToFile strZip, 2
	objStream.Close
	Set objSrvHTTP = Nothing
	Set objStream = Nothing

	'UnZip
	Dim objApp, objZip
	Set objApp = CreateObject("Shell.Application")
	Set objZip = objApp.NameSpace(strFolder + strZip)
	objApp.Namespace(strFolder).CopyHere(objZip.items)
	objFileSys.DeleteFile(strFolder + strZip)
	Set objApp = Nothing
	Set objZip = Nothing

	'Rename AutoHotkey.exe to MouseGestureL.exe
	Dim objFile
	Set objFile = objFileSys.GetFile(strFolder + strAHK)
	objFile.Name = strMGL
	Set objFileSys = Nothing
	Set objFile = Nothing

	'Run AHK
	dim objWShell
	Set objWShell = WScript.CreateObject("WScript.Shell")
	objWShell.Run(strMGL)
	Set objWShell = Nothing

	WScript.Timeout=1
	WScript.Sleep 1200
End Sub
