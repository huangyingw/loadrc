#!/bin/zsh

if [ $(uname) = "Darwin" ]
then
    pmset displaysleepnow
    #pmset sleepnow
else
    # ~/loadrc/gpurc/kill_nvidia.sh
    pm-suspend
fi
