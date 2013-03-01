@echo off

rem Move up to the parent directory 
cd ..
rem This will be the base directory
set BASE_DIR=%cd%

rem Set java options
set JAVA_OPT= 
set JAVA_CLASSPATH=

for /R .\server\lib %%a in (*.jar) do call :AddToPath %%a

rem Run java 
java %JAVA_OPT% -cp %JAVA_CLASSPATH% com.rameses.websocket.WebsocketServer
goto :EOF

:AddToPath
set JAVA_CLASSPATH=%1;%JAVA_CLASSPATH%
goto :EOF
