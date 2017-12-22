## 环境准备：

  1、Java 开发或者运行环境：http://download.oracle.com/otn/java/jdk/7u80-b15/jre-7u80-windows-i586.exe
  
  2、下载 Apache Commons Daemon Windows：http://www.apache.org/dist/commons/daemon/binaries/windows/
 
## Java工程

首先新建一个Java工程，新建Java服务器类，实现org.apache.commons.daemon.Daemon接口，同时还得提供 public static void start(String[] args) 方法，
否则服务启动的时候会提示：xxxx 服务由于下列服务特定错误而终止: 函数不正确。

## 导出可执行jar包

工程新建后，导出成可执行jar包，然后编写注册服务的service.bat文件,

## service.bat
·
@echo off
set SERVICE_NAME=ABWebSocketServer
set PR_INSTALL=C:\AppStore\service\bin\prunsrv.exe 

C delete %SERVICE_NAME%

REM Service log configuration

mkdir C:\AppStore\service\log\

set PR_LOGPREFIX=%SERVICE_NAME%
set PR_LOGPATH=C:\AppStore\service\log\
set PR_STDOUTPUT=C:\AppStore\service\log\stdout.txt
set PR_STDERROR=C:\AppStore\service\log\stderr.txt
set PR_LOGLEVEL=Error

REM Path to java installation

set PR_JVM=C:\Program Files\Java\jre7\bin\client\jvm.dll
if exist "%PR_JVM%" goto foundJvm  
set PR_JVM=C:\Program Files (x86)\Java\jre7\bin\client\jvm.dll
if exist "%PR_JVM%" goto foundJvm  
set PR_JVM=auto  

:foundJvm  
echo Using JVM:%PR_JVM% 

set PR_CLASSPATH=C:\AppStore\service\abwebsocket.jar

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

·
