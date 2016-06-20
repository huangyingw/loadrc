#!/bin/bash - 
~/loadrc/bashrc/smount.sh "$1"
mosh "$1" -- ${tmuxAction}
