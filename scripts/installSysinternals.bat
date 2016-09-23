@echo off

setlocal
set SYSINTERNALS_DIR=%PROGRAMFILES%\Sysinternals

echo Extract Sysinternals Suite
7z.exe x "%USERPROFILE%\Downloads\SysinternalsSuite.zip" -o"%SYSINTERNALS_DIR%" -y

echo Add "%SYSINTERNALS_DIR%" to PATH
setx /M PATH "%PATH%;%SYSINTERNALS_DIR%"

echo Accept EULA for SDelete
reg ADD HKEY_CURRENT_USER\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f

endlocal
