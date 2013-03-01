#!/bin/sh
# Move up to the parent directory
cd ..

# This will the base directory
BASE_DIR=`pwd`

# This will be the context directory (osiris.home). You can changed the location anytime.
CONTEXT_DIR=$BASE_DIR/context

# set the java home if neccessary
# JAVA_HOME=

# set java options
JAVA_CLASSPATH=$(echo server/lib/*.jar | tr ' ' ':')
JAVA_CLASSPATH=$JAVA_CLASSPATH:$(echo server/lib.ext/*.jar | tr ' ' ':')

JAVA_OPTS="-Dosiris.home=file:///$CONTEXT_DIR" 

# run java
if [ "x$JAVA_HOME" = "x" ]; then
   JAVA="java"
else
   JAVA="$JAVA_HOME/bin/java"
fi

$JAVA $JAVA_OPTS -cp $JAVA_CLASSPATH com.rameses.osiris3.server.common.OsirisServerBootstrap

