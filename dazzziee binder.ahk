; #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; #NoTrayIcon
#SingleInstance Forcestr
strComputer := "."
objWMIService := ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . strComputer . "\root\cimv2")
colSettings := objWMIService.ExecQuery("Select * from Win32_OperatingSystem")._NewEnum
While colSettings[objOSItem]
{
Key := objOSItem.SerialNumber
}
URLDownloadToFile, https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1lAAj-1MVMMGG2CeQJeqnu8PQ1WmWMjsJ, %a_temp%/keys.dat
fileread, read, %a_temp%/keys.dat
if read contains %Key%
goto true
Gui, -Caption 
Gui, Show, xCenter ycenter h463 w1200, Доступ.
Gui, add, picture, x0 y0 h463 w1200, %A_WorkingDir%/dev/HWID.png
Gui, Add, Text, x122 y29 w270 h30 , Ключ:
Gui, Add, Edit, x195 y190 w810.53 h30 ReadOnly vEdit,
Gui, Add, button, x397 y247 w400 h50 gClip, Скопировать ключ
GuiControl, , Edit, % Key
return
Clip:
Gui, Submit, NoHide
Clipboard := Edit
ExitApp
GuiClose:
ExitApp
true:

buildscr = 20
downlurl := "https://jeazz.ucoz.net/ahk/pr/RiveraGos.ahk"
downllen := "https://jeazz.ucoz.net/ahk/pr/verlen.ini"
SplashTextOn, , 60,Проверка обновления, ожидайте.`nНайдено обновление.
URLDownloadToFile, %downllen%, %a_temp%/verlen.ini

IniRead, buildupd, %a_temp%/verlen.ini, UPD, build
sleep, 1200

if buildupd = 20
{
    SplashTextOn, , 60,�������������, ���������� �� �������.
    sleep, 1000
}
if buildupd > % buildscr
{
	IniRead, vupd, %a_temp%/verlen.ini, UPD, v
    SplashTextOn, , 60,че изменено %vupd%!
    sleep, 1200
	FileReadLine, desupd1, %a_temp%/verlen.ini, 5
   	FileReadLine, desupd2, %a_temp%/verlen.ini, 6 
	FileReadLine, desupd3, %a_temp%/verlen.ini, 7
	FileReadLine, desupd4, %a_temp%/verlen.ini, 8
	FileReadLine, desupd5, %a_temp%/verlen.ini, 9
	SplashTextoff
    Filedelete, %a_temp%\verlen.ini
	msgbox, 0, 1 %vupd%, %desupd1% %desupd2% %desupd3% %desupd4% %desupd5%
    IfMsgBox OK
    {
        msgbox, 8193, 1 %vupd%, Желаете обновить?
        IfMsgBox OK
        {
            put2 := % A_ScriptFullPath
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
            SplashTextOn, , 60,ку, два.`nобновилось %vupd%!
			URLDownloadToFile, %downlurl%,%A_ScriptDir%\RiveraGos.ahk
			sleep, 1100
            run, %A_ScriptDir%\RiveraGos.ahk
        } 
            
			IfMsgBox Cancel
			{
              ExitApp
			}
    }
}

