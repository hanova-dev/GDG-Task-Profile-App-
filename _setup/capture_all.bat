@echo off
title Capturing app screenshots
set PATH=C:\Android\Sdk\platform-tools;%PATH%
cd /d D:\GDG\profile
if not exist screenshots mkdir screenshots
if exist screenshots\screenshot_1.png del screenshots\screenshot_1.png

rem --- Profile screen (Task 1) ---
adb shell input tap 270 2232
timeout /t 2 >nul
call :shot 01_profile_top
adb shell input swipe 540 1800 540 700 400
timeout /t 2 >nul
call :shot 02_profile_middle
adb shell input swipe 540 1800 540 500 400
timeout /t 2 >nul
call :shot 03_profile_bottom

rem --- Portfolio screen (Task 2) ---
adb shell input tap 810 2232
timeout /t 2 >nul
call :shot 04_portfolio_top
adb shell input swipe 540 1800 540 700 400
timeout /t 2 >nul
call :shot 05_portfolio_middle
adb shell input swipe 540 1800 540 500 400
timeout /t 2 >nul
call :shot 06_portfolio_bottom
echo done > screenshots\done.txt
goto :eof

:shot
adb shell screencap -p /sdcard/shot.png
adb pull /sdcard/shot.png screenshots\%1.png >nul
goto :eof
