#!/bin/zsh

if [ -z $(git symbolic-ref -q HEAD) ]
then
    exit
fi

parallel --jobs 0 -k ::: \
    ~/loadrc/gitrc/gps.sh \
    ~/loadrc/gitrc/gpl.sh \
    ~/loadrc/gitrc/dogdio.sh
