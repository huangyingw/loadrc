#!/bin/bash
x=`pwd`
x=`echo "$x" | sed -e "s|myproject|BareReps/myproject|"`
x=`echo "$x" | sed -e "s|loadrc|BareReps/loadrc|"`
x=`echo "$x" | sed -e "s|imvu|BareReps/imvu|"`
echo "BareReps location --> $x"

if [ ! -d "$x" ];
then
    git clone --bare . "$x"
fi

git remote rm BareReps
git remote add BareReps "$x"
