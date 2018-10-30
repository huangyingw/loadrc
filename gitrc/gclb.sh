#!/bin/bash
x=`pwd`
x=`echo "$x" | sed -e "s|myproject|BareReps/myproject|"`
x=`echo "$x" | sed -e "s|loadrc|BareReps/loadrc|"`
x=`echo "$x" | sed -e "s|imvu|BareReps/imvu|"`
x=$(realpath --relative-to="$PWD" "$x")
echo "BareReps location --> $x"

if [ ! -d "$x" ]
then
    mkdir -p $(dirname "$x")
    git clone --bare . "$x"
fi

git remote add BareReps "$x"
