#!/bin/bash
branch=`git branch |awk '/\*/{print $2}'`
if [ -f dropbox.only ];
then
  git pull dropbox $branch
  exit 0
fi
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do 
  git pull $ss $branch
done
