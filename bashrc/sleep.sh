#!/bin/zsh
if [ $(uname) = "Darwin" ]
then
    pmset sleepnow
else
    pm-suspend
fi
