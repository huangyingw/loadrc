#!/bin/zsh

if [ -z $(git symbolic-ref -q HEAD) ]
then
    exit
fi

~/loadrc/gitrc/gps.sh &
~/loadrc/gitrc/gpl.sh
~/loadrc/gitrc/dogdio.sh
