@echo off

setlocal
if defined USERPROFILE (
    call :EMPTY_DIRECTORY "%USERPROFILE%\Downloads"
)

if defined TEMP (
    call :EMPTY_DIRECTORY "%TEMP%"
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
