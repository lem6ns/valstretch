@echo off

set stretchedWidth = %1
set stretchedHeight = %2
set stretchedRefreshRate = %3

set normalWidth = %4
set normalHeight = %5
set normalRefreshRate = %6

START %~dp0QRes.exe /x:%stretchedWidth% /y:%stretchedHeight% /c:32 /r:%stretchedRefreshRate%

powershell Set-ExecutionPolicy Bypass -Scope Process -Force;"%~dp0maximize_and_remove_borders.ps1">NUL

:whileval
timeout 7 > NUL
tasklist /FI "IMAGENAME eq VALORANT-Win64-Shipping.exe" 2>NUL | find /I /N "VALORANT-Win64">NUL
if "%ERRORLEVEL%"=="0" goto :whileval

START %~dp0QRes.exe /x:%normalWidth% /y:%normalHeight% /c:32 /r:%normalRefreshRate%