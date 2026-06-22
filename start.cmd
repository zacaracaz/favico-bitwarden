@echo off
REM favico x Bitwarden - double-click me (Windows). Installs Node if needed, then runs the guided launcher.
setlocal enableextensions
cd /d "%~dp0"

where node >nul 2>nul && goto run

echo.
echo Node.js is required but was not found.
where winget >nul 2>nul
if errorlevel 1 (
  echo Could not find winget to auto-install it.
  echo Please install Node.js LTS from https://nodejs.org then run this again.
  echo.
  pause
  exit /b 1
)

set /p ANS=Install Node.js LTS now via winget? [Y/N]
if /i not "%ANS%"=="Y" (
  echo Skipped. Install Node.js from https://nodejs.org then run this again.
  pause
  exit /b 1
)

winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements

REM Make THIS window aware of the freshly-installed Node without reopening.
set "PATH=%PATH%;%ProgramFiles%\nodejs;%ProgramFiles(x86)%\nodejs"
where node >nul 2>nul && goto run

echo.
echo Node.js was installed, but this window needs to be reopened to use it.
echo Please close this window and double-click start.cmd again.
pause
exit /b 0

:run
node "%~dp0start.mjs" %*
echo.
pause
