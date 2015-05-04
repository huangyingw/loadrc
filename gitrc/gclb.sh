#!/bin/bash

x=`pwd`
echo ${x}
x=`echo ${x} | sed -e "s|/.*/myproject|/media/smb/myproject|"`
echo ${x}

if [ ! -d ".git" ];
then
  git init
  git add .
  git commit -am "n"
else
  if [ -d ${x} ];
  then
    echo remote exist!!!
  fi
fi
git clone --bare . ${x}
git remote rm origin
git remote add origin ${x}
