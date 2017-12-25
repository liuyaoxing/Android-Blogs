#!/bin/sh

# ----------------------------------------------------------------------------
# Contributors: liuyaoxing@gmail.com
# Version: 1.3
# ----------------------------------------------------------------------------

abs_name='ITS_YL_101'

PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

ABS_HOME=`dirname "$PRG"`/"$link"

cd $ABS_HOME

if [ ! -e restart.info ]; then
   touch restart.info
   echo $(date +%Y"."%m"."%d" "%k":"%M":"%S): new file >> restart.info
fi

logDebug() {
   echo $1
   echo $(date +%Y"."%m"."%d" "%k":"%M":"%S): $1 >> restart.info
   echo $(date +%Y"."%m"."%d" "%k":"%M":"%S): $1 >> nohup.out
}

logNetstat() {
   echo ""
   echo "netstat -nap|grep $1="
   netstat -nap|grep $1
   netstat -nap|grep $1 >> restart.info
   echo ""
}

PID=`ps -ef|grep java|grep "abs=$abs_name "|awk '{print "\t"$2}'`
OPID=`ps -ef|grep java|grep "abs=$abs_name "|awk '{print "\t"$2}'`

logDebug "------------------------------------------------------------------"
logDebug "ABS_NAME=$abs_name, ABS_HOME=$ABS_HOME, PWD=$PWD, PID=$PID"

logNetstat $PID

COUNTER=0
while [ "$PID" != "" ] && [ $COUNTER -lt 10 ];
do
  COUNTER=`expr $COUNTER + 1`
  cd $ABS_HOME
  logDebug "ABS appears to still be running with PID $PID. Start aborted. (sh $PWD/close.sh)"
  sh close.sh >> nohup.out
  sleep 10
  PID=`ps -ef|grep java|grep "abs=$abs_name "|awk '{print "\t"$2}'`
done

if [ "$PID" != "" ]; then
   logDebug "ABS:$PID will be killed! "
   kill -9 $PID >/dev/null 2>&1
   PID=`ps -ef|grep java|grep "abs=$abs_name "|awk '{print "\t"$2}'`
   if [ "$PID" != "" ]; then
       kill -9 $PID
   else
       logDebug "ABS had bean killed! "
   fi
   
   COUNTER=0
   while [ "$PID" != "" ] && [ $COUNTER -lt 10 ];
   do
     COUNTER=`expr $COUNTER + 1`
     logDebug "ABS appears to still be running with PID $PID, will sleep 5s ..."
     sleep 5
     PID=`ps -ef|grep java|grep "abs=$abs_name "|awk '{print "\t"$2}'`
   done
fi

PID=`ps -ef|grep java|grep "abs=$abs_name "|awk '{print "\t"$2}'`

if [ "$PID" == "" ]; then
   logDebug "ABS had bean stoped"
fi

echo ""

COUNTER=0
while [ "$PID" == "" ] && [ $COUNTER -lt 10 ];
do
  COUNTER=`expr $COUNTER + 1`
  cd $ABS_HOME
  logDebug "ABS is Starting... (sh $PWD/abs_main.sh)"
  sh abs_main.sh
  sleep 10
  PID=`ps -ef|grep java|grep "abs=$abs_name "|awk '{print "\t"$2}'`
done

echo ""

if [ "$PID" != "" ] && [ "$PID" != "$OPID" ]; then
   logDebug "ABS:$PID had bean restarted! "
else
   logDebug "ABS:$abs_name restart fail! "
fi

logNetstat $PID

logDebug "=================================================================="