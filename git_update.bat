@echo off
title Git Auto-Update Script
echo ====================================================
echo             GIT AUTO-UPDATE TOOL
echo ====================================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in your PATH.
    echo Please install Git and try again.
    pause
    exit /b 1
)

:: Show current git status
echo [INFO] Current Git Status:
echo ----------------------------------------------------
git status -s
echo ----------------------------------------------------
echo.

:: Check if there are any changes
git status --porcelain | findstr "^" >nul
if %errorlevel% neq 0 (
    echo [INFO] No changes detected. Repository is up-to-date.
    echo.
    pause
    exit /b 0
)

:: Clear commit_msg variable first
set "commit_msg="

:: Ask for commit message
set /p commit_msg="Enter commit message (press Enter for default 'Minor updates'): "

:: If user pressed enter, set default commit message
if "%commit_msg%"=="" (
    set "commit_msg=Minor updates"
)

echo.
echo [INFO] Staging all files...
git add .

echo [INFO] Committing changes...
git commit -m "%commit_msg%"

echo [INFO] Pushing to remote repository...
git push

if %errorlevel% equ 0 (
    echo.
    echo ====================================================
    echo [SUCCESS] Git repository updated successfully!
    echo ====================================================
) else (
    echo.
    echo ====================================================
    echo [ERROR] Failed to push changes. Check your network or credentials.
    echo ====================================================
)

echo.
pause
