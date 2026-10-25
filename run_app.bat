@echo off
title Profile App - setup and run
set PATH=C:\flutter\bin;C:\Android\Sdk\platform-tools;C:\Android\Sdk\emulator;%PATH%
cd /d D:\GDG\profile
set LOG=D:\GDG\profile\_setup\log.txt
echo ==== %date% %time% ==== > "%LOG%"

if not exist profile_app\pubspec.yaml (
  echo Creating Flutter project...
  call flutter create --project-name profile_app --org com.hanan --platforms android profile_app >> "%LOG%" 2>&1
)
echo Copying code and assets...
copy /Y _setup\main.dart profile_app\lib\main.dart >> "%LOG%" 2>&1
copy /Y _setup\pubspec.yaml profile_app\pubspec.yaml >> "%LOG%" 2>&1
copy /Y _setup\widget_test.dart profile_app\test\widget_test.dart >> "%LOG%" 2>&1
if not exist profile_app\assets mkdir profile_app\assets
copy /Y assets\profile.png profile_app\assets\profile.png >> "%LOG%" 2>&1

cd profile_app
echo Running flutter pub get...
call flutter pub get >> "%LOG%" 2>&1
echo Running flutter analyze...
call flutter analyze >> "%LOG%" 2>&1

emulator -list-avds > ..\_setup\avds.txt 2>&1
type ..\_setup\avds.txt >> "%LOG%"
set AVD=
for /f "usebackq delims=" %%a in ("..\_setup\avds.txt") do if not defined AVD set AVD=%%a
adb devices | find "emulator-" >nul
if errorlevel 1 (
  echo Starting emulator %AVD%...
  start "" emulator -avd %AVD%
)
echo Waiting for emulator to boot...
adb wait-for-device
:boot
adb shell getprop sys.boot_completed 2>nul | find "1" >nul
if errorlevel 1 (
  timeout /t 3 >nul
  goto boot
)
echo Emulator ready. >> "%LOG%"
adb devices >> "%LOG%"
echo Launching app...
call flutter run -d emulator-5554
pause
