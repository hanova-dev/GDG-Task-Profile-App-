@echo off
title Capturing contact screens
set PATH=C:\Android\Sdk\platform-tools;%PATH%
cd /d D:\GDG\profile
del screenshots\03_profile_bottom.png screenshots\06_portfolio_bottom.png screenshots\done.txt 2>nul

rem Portfolio screen is scrolled to the bottom: tap Contact Me
adb shell input tap 560 1983
timeout /t 2 >nul
call :shot 06_portfolio_contact_sheet
adb shell input keyevent 4
timeout /t 1 >nul

rem Back to Profile screen and tap its Contact Me button
adb shell input tap 270 2232
timeout /t 2 >nul
adb shell input tap 540 1998
timeout /t 1 >nul
call :shot 03_profile_contact_snackbar
echo done > screenshots\done.txt
goto :eof

:shot
adb shell screencap -p /sdcard/shot.png
adb pull /sdcard/shot.png screenshots\%1.png >nul
goto :eof
