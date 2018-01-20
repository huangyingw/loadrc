#!/bin/bash
OS=`uname`
if [ "$OS" == "Darwin" ]
then
    pmset sleepnow
else
    pm-suspend
fi
