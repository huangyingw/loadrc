#!/bin/bash
if [ ! -z "$1" ];
then
  cd "$1"
fi
folder=`pwd | sed -e 's/\/.*\///g'`
#TESTGIT=`git remote|grep -q gh`
#if  [ ! -z "${TESTGIT}" ];
#then
gh=git@github.com:huangyingw/$folder.git
git remote rm gh
git remote add gh ${gh}
#fi
