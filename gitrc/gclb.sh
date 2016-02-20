#!/bin/bash
x=`pwd`
x=`echo ${x} | sed -e "s|/.*/myproject|$HOME/Dropbox/myproject|"`
echo ${x}

if [ ! -d ${x} ];
then
  git clone --bare . ${x}
fi
git remote add dropbox ${x}
