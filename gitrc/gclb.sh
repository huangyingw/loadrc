#!/bin/zsh

if (git remote | grep -q BareReps)
then
    return
fi

x=`pwd`
x=`echo "$x" | sed -e "s|myproject|BareReps/myproject|"`
x=`echo "$x" | sed -e "s|loadrc|BareReps/loadrc|"`
x=`echo "$x" | sed -e "s|workspace|BareReps/workspace|"`
mkdir -p $(dirname "$x")
x=$(python -c "import os.path; print(os.path.relpath('${x}', '${PWD}'))")
echo "BareReps location --> $x"

if [ ! -d "$x" ]
then
    git clone --bare . "$x"
fi

git remote add BareReps "$x"
