@echo off
set PATH=C:\Android\Sdk\platform-tools;%PATH%
cd /d D:\GDG\profile
if not exist screenshots mkdir screenshots
set n=1
:loop
if exist screenshots\screenshot_%n%.png (
  set /a n+=1
  goto loop
)
adb exec-out screencap -p > screenshots\screenshot_%n%.png
