#!/bin/sh
# Move up to the parent directory
cd ..

# This will the base directory
BASE_DIR=`pwd`

# set the java home if neccessary
# JAVA_HOME=

# set java options
JAVA_CLASSPATH=$(echo server/lib/*.jar | tr ' ' ':')

JAVA_OPTS="-Dweb.home.dir=$BASE_DIR -Dweb.conf.dir=$BASE_DIR/bin -Dweb.lib.dir=$BASE_DIR/server" 

# run java
if [ "x$JAVA_HOME" = "x" ]; then
   JAVA="java"
else
   JAVA="$JAVA_HOME/bin/java"
fi

$JAVA $JAVA_OPTS -cp $JAVA_CLASSPATH com.rameses.anubis.web.WebServer

