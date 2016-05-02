#!/bin/bash
x=`pwd`
x=`echo ${x} | sed -e "s|/.*/myproject|$HOME/BareReps/myproject|"`
echo ${x}

if [ ! -d ${x} ];
then
  git clone --bare . ${x}
fi
git remote rm dropbox
git remote add dropbox ${x}
