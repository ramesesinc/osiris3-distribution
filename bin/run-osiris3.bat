@echo off

rem Move up to the parent directory 
cd ..
rem This will be the base directory
set BASE_DIR=%cd%
rem This will be the context directory (osiris.home). You can changed the location anytime.  
set CONTEXT_DIR=%BASE_DIR%\context

set JAVA_OPT="-Dosiris.home=file:///%CONTEXT_DIR%" 
set JAVA_CLASSPATH=

for /R .\server\lib %%a in (*.jar) do call :AddToPath %%a
for /R .\server\lib.ext %%a in (*.jar) do call :AddToPath %%a

java %JAVA_OPT% -cp %JAVA_CLASSPATH% com.rameses.osiris3.server.common.OsirisServerBootstrap
goto :EOF

:AddToPath
set JAVA_CLASSPATH=%1;%JAVA_CLASSPATH%
goto :EOF
