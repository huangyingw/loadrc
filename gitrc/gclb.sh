#!/bin/bash
x=`pwd`
x=`echo "$x" | sed -e "s|myproject|BareReps|"`
x=`echo "$x" | sed -e "s|loadrc|BareReps/boad|"`
echo "BareReps location --> $x"

if [ ! -d "$x" ];
then
    git clone --bare . "$x"
fi

git remote rm BareReps
git remote add BareReps "$x"
