#!/bin/zsh

if (git remote | grep -q BareReps)
then
    return
fi

x=`pwd`
x=`echo "$x" | sed -e "s|myproject|BareReps/myproject|"`
x=`echo "$x" | sed -e "s|loadrc|BareReps/loadrc|"`
x=`echo "$x" | sed -e "s|imvu|BareReps/imvu|"`
mkdir -p $(dirname "$x")
x=$(realpath --relative-to="$PWD" "$x")
echo "BareReps location --> $x"

if [ ! -d "$x" ]
then
    git clone --bare . "$x"
fi

git remote add BareReps "$x"
