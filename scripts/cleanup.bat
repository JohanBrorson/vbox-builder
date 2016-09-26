@echo off

setlocal
if defined USERPROFILE (
    call :EMPTY_DIRECTORY "%USERPROFILE%\Downloads"
)

if defined TEMP (
    call :EMPTY_DIRECTORY "%TEMP%"
)

set REGISTRY_KEY=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
set REGISTRY_VALUE=SKIP_WINDOWS_UPDATES
reg query "%REGISTRY_KEY%" /v %REGISTRY_VALUE%
if %ERRORLEVEL% equ 0 (
  echo Remove registry value
  reg delete "%REGISTRY_KEY%" /v %REGISTRY_VALUE% /f
)


echo Zeroing free space
sdelete -q -z %SystemDrive%

goto :END

:EMPTY_DIRECTORY
set DIRECTORY=%*
echo Clean directory %DIRECTORY%
del /s /q "%DIRECTORY%\*"
for /d %%i IN ("%DIRECTORY%\*") do rd /S /Q "%%i"
goto :EOF

:END
endlocal
