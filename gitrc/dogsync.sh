#!/bin/zsh

if [ -z $(git symbolic-ref -q HEAD) ]
then
    exit
fi

~/loadrc/gitrc/dogdio.sh
~/loadrc/gitrc/gclb.sh
~/loadrc/gitrc/gps.sh &
~/loadrc/gitrc/gpl.sh
