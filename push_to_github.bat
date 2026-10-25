@echo off
title Push to GitHub
cd /d D:\GDG\profile
set LOG=D:\GDG\profile\_setup\push_log.txt
echo ==== %date% %time% ==== > "%LOG%"

copy /Y _setup\README.md README.md >> "%LOG%" 2>&1
if not exist .gitignore (
  echo .dart_tool/> .gitignore
  echo build/>> .gitignore
)

git status --short >> "%LOG%" 2>&1
git add -A >> "%LOG%" 2>&1
git commit -m "Add README with screenshots and updated task report" >> "%LOG%" 2>&1
echo --- pull --- >> "%LOG%"
git pull --no-rebase --no-edit origin main >> "%LOG%" 2>&1
echo --- push --- >> "%LOG%"
git push origin main >> "%LOG%" 2>&1
echo push exit code %errorlevel% >> "%LOG%"
git log --oneline -5 >> "%LOG%" 2>&1
git status -sb >> "%LOG%" 2>&1
echo Finished.
timeout /t 5
