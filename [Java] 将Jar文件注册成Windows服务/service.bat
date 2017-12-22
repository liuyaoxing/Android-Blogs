@echo off

set SERVICE_NAME=ABWebSocketServer
set PR_INSTALL=C:\ABC_NEW\service\bin\prunsrv.exe 

SC delete %SERVICE_NAME%

REM Service log configuration

mkdir C:\ABC_NEW\service\log\

set PR_LOGPREFIX=%SERVICE_NAME%
set PR_LOGPATH=C:\ABC_NEW\service\log\
set PR_STDOUTPUT=C:\ABC_NEW\service\log\stdout.txt
set PR_STDERROR=C:\ABC_NEW\service\log\stderr.txt
set PR_LOGLEVEL=Error

REM Path to java installation

set PR_JVM=C:\Program Files\Java\jre7\bin\client\jvm.dll
if exist "%PR_JVM%" goto foundJvm  
set PR_JVM=C:\Program Files (x86)\Java\jre7\bin\client\jvm.dll
if exist "%PR_JVM%" goto foundJvm  
set PR_JVM=auto  

:foundJvm  
echo Using JVM:%PR_JVM% 

set PR_CLASSPATH=C:\ABC_NEW\service\abwebsocket.jar

REM Startup configuration

set PR_STARTUP=auto
set PR_STARTMODE=jvm
set PR_STARTCLASS=ab.websocket.WebSocketServer
set PR_STARTMETHOD=start

REM Shutdown configuration

set PR_STOPMODE=jvm
set PR_STOPCLASS=ab.websocket.WebSocketServer
set PR_STOPMETHOD=stop

REM JVM configuration

set PR_JVMMS=64
set PR_JVMMX=128
set PR_JVMSS=4000

REM Install service

%PR_INSTALL% //IS//%SERVICE_NAME%

NET START %SERVICE_NAME%

pause