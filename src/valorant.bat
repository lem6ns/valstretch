@echo off

:: change this command to your desired resolution and/or refresh rate
:: (if this is a custom res, make sure it is created in NVIDIA Control Panel & alike)
set /A stretchedWidth=1440
set /A stretchedHeight=1080
set /A stretchedRefreshRate=144

set /A normalWidth=1920
set /A normalHeight=1080
set /A normalRefreshRate=144

MODE CON: COLS=100 LINES=13
echo.
echo                             --------------------------------------
echo                             ^|             README.txt             ^|
echo                             --------------------------------------
echo.
echo  1. Please change the refresh rate and resolution to the correct values in this file. **IMPORTANT**
echo             2. After opening VALORANT, choose fullscreen, click fill, then apply.
echo                                 3. Choose windowed, and apply.
echo                         4. Focus the command prompt and press any key.
echo                            5. Your game should now be stretched.
echo.
echo                         Press any key after reading these instructions.
pause >NUL

tasklist /FI "IMAGENAME eq VALORANT-Win64-Shipping.exe" 2>NUL | find /I /N "VALORANT-Win64">NUL
if "%ERRORLEVEL%"=="1" START /b "" "%CD:~0,3%Riot Games\Riot Client\RiotClientServices.exe" --launch-product=valorant --launch-patchline=live

MODE CON: COLS=53 LINES=7
echo.
echo      1. Choose fullscreen, choose fill and apply.
echo             2. Choose windowed, and apply.
echo                   3. Press any key.
echo          4. Your game should now be stretched.
echo       Close this window or press CTRL+C to exit.

pause >NUL
cls

MODE CON: COLS=15 LINES=2
echo Leave me open!
START %~dp0utils\QRes.exe /x:%stretchedWidth% /y:%stretchedHeight% /c:32 /r:%stretchedRefreshRate%

powershell Set-ExecutionPolicy Bypass -Scope Process -Force;"%~dp0utils\maximize_and_remove_borders.ps1">NUL

:whileval
timeout 7 > NUL
tasklist /FI "IMAGENAME eq VALORANT-Win64-Shipping.exe" 2>NUL | find /I /N "VALORANT-Win64">NUL
if "%ERRORLEVEL%"=="0" goto :whileval

START %~dp0utils\QRes.exe /x:%normalWidth% /y:%normalHeight% /c:32 /r:%normalRefreshRate%
