#!/bin/zsh

if [ -z $(git symbolic-ref -q HEAD) ]
then
    exit
fi

~/loadrc/gitrc/gpl.sh
~/loadrc/gitrc/gps.sh
~/loadrc/gitrc/dogdio.sh
