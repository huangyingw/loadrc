#!/bin/bash
x=`pwd`
x=`echo ${x} | sed -e "s|/.*/myproject|$HOME/Dropbox/myproject|"`
echo ${x}

git clone --bare . ${x}
git remote add dropbox ${x}
