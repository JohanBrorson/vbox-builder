@echo off

setlocal

if exist "%PROGRAMFILES%\Mozilla Firefox" (
  set "FF_PATH=%PROGRAMFILES%\Mozilla Firefox"
)

if exist "%PROGRAMFILES(X86)%\Mozilla Firefox" (
  set "FF_PATH=%PROGRAMFILES(X86)%\Mozilla Firefox"
)

if not defined FF_PATH goto :NO_FIREFOX

set PREFERENCES_PATH=%FF_PATH%\browser\defaults\preferences
set AUTOCONFIG_JS=%PREFERENCES_PATH%\autoconfig.js
set OVERRIDE_INI=%FF_PATH%\browser\override.ini
set MOZILLA_CFG=%FF_PATH%\mozilla.cfg

call :REMOVE_FILE %AUTOCONFIG_JS%
call :REMOVE_FILE %OVERRIDE_INI%
call :REMOVE_FILE %MOZILLA_CFG%

if not exist "%PREFERENCES_PATH%" (
  md "%PREFERENCES_PATH%"
)

echo Create %AUTOCONFIG_JS%
(echo pref^("general.config.filename", "mozilla.cfg"^);) >> "%AUTOCONFIG_JS%"
(echo pref^("general.config.obscure_value", 0^);)        >> "%AUTOCONFIG_JS%"
call :IS_FILE_CREATED "%AUTOCONFIG_JS%" || goto :FILE_NOT_CREATED

echo Create %OVERRIDE_INI%
(echo [XRE])                   >> "%OVERRIDE_INI%"
(echo EnableProfileMigrator=0) >> "%OVERRIDE_INI%"
call :IS_FILE_CREATED "%OVERRIDE_INI%" || goto :FILE_NOT_CREATED

echo Create %MOZILLA_CFG%
(echo // Set default homepage)                                          >> "%MOZILLA_CFG%"
(echo pref^("browser.startup.homepage","about:blank"^);)                >> "%MOZILLA_CFG%"
(echo // Disable default browser check)                                 >> "%MOZILLA_CFG%"
(echo pref^("browser.shell.checkDefaultBrowser", false^);)              >> "%MOZILLA_CFG%"
(echo // Don't display 'know you rights' and WhatsNew)                  >> "%MOZILLA_CFG%"
(echo pref^("browser.rights.3.shown", true^);)                          >> "%MOZILLA_CFG%"
(echo pref^("browser.startup.homepage_override.mstone","ignore"^);)     >> "%MOZILLA_CFG%"
(echo //Disable plugin checking)                                        >> "%MOZILLA_CFG%"
(echo lockPref^("plugins.hide_infobar_for_outdated_plugin", true^);)    >> "%MOZILLA_CFG%"
(echo clearPref^("plugins.update.url"^);)                               >> "%MOZILLA_CFG%"
(echo // Disable health reporter)                                       >> "%MOZILLA_CFG%"
(echo lockPref^("datareporting.healthreport.service.enabled", false^);) >> "%MOZILLA_CFG%"
(echo // Disable all data upload ^(Telemetry and FHR^))                 >> "%MOZILLA_CFG%"
(echo lockPref^("datareporting.policy.dataSubmissionEnabled", false^);) >> "%MOZILLA_CFG%"
(echo // Disable crash reporter)                                        >> "%MOZILLA_CFG%"
(echo lockPref^("toolkit.crashreporter.enabled", false^);)              >> "%MOZILLA_CFG%"
(echo Components.classes["@mozilla.org/toolkit/crash-reporter;1"].getService^(Components.interfaces.nsICrashReporter^).submitReports = false;) >> "%MOZILLA_CFG%"
call :IS_FILE_CREATED "%MOZILLA_CFG%" || goto :FILE_NOT_CREATED

goto END


:REMOVE_FILE
if exist %1 (
  echo Delete %1
  del /f "%1"
)
goto :EOF

:IS_FILE_CREATED
if not exist %1 (
  echo ERROR: %1 doesn't exist
  exit /b 2
)
if %~z1 EQU 0 (
  echo ERROR: %1 is empty
  exit /b 3
)
echo Successfully created %~nx1
goto :EOF

:NO_FIREFOX
echo ERROR: Failed to find the Firefox directory
exit /b 1

:FILE_NOT_CREATED
echo ERROR: Failed to find create file
exit /b 1

:END
endlocal
