#!/bin/sh
# Move up to the parent directory
cd ..

# This will the base directory
BASE_DIR=`pwd`

# set the java home if neccessary
# JAVA_HOME=

# set java options
JAVA_CLASSPATH=$(echo server/lib/*.jar | tr ' ' ':')

JAVA_OPTS= 

# run java
if [ "x$JAVA_HOME" = "x" ]; then
   JAVA="java"
else
   JAVA="$JAVA_HOME/bin/java"
fi

$JAVA $JAVA_OPTS -cp $JAVA_CLASSPATH com.rameses.websocket.WebsocketServer

