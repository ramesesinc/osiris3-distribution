@echo off

rem Move up to the parent directory 
cd ..
rem This will be the base directory
set BASE_DIR=%cd%
rem Setup few options needed for the web configuration
set JAVA_OPT=-Dweb.home.dir=%BASE_DIR% -Dweb.conf.dir=%BASE_DIR%/bin -Dweb.lib.dir=%BASE_DIR%/server 
set JAVA_CLASSPATH=

for /R .\server\lib %%a in (*.jar) do call :AddToPath %%a

java %JAVA_OPT% -cp %JAVA_CLASSPATH% com.rameses.anubis.web.WebServer
pause
goto :EOF

:AddToPath
set JAVA_CLASSPATH=%1;%JAVA_CLASSPATH%
goto :EOF
