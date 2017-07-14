#!/bin/bash
x=`pwd`
x=`echo "$x" | sed -e "s|/.*/myproject|~/BareReps/myproject|"`
x=`echo "$x" | sed -e "s|/.*/loadrc|~/BareReps/loadrc|"`
echo "$x"

if [ ! -d "$x" ];
then
    git clone --bare . "$x"
fi

git remote add BareReps "$x"
