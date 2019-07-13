#!/bin/bash

LOG_DATE=$(date +%d_%b-%T%p)
WORKING_DIR=$PWD
LOG_FILE=$WORKING_DIR/$LOG_DATE.log

# Read packages.list
LIST=$(cat packages.list | tr "\n" " ")
echo -e "Debloating..."
for PACKAGE in $LIST
do
    adb shell pm uninstall $PACKAGE > /dev/null 2>&1
    PKG_STAT=$(adb shell pm uninstall --user 0 $PACKAGE)
if [ "$PKG_STAT" == "Success" ]
    then echo -e "Package \"$PACKAGE\" removed successfully..." >> $LOG_FILE
else
    echo -e "Package \"$PACKAGE\" not found So NOT removed..." >> $LOG_FILE
fi
done;
echo -e "Debloat completed check logfile : $LOG_FILE"
