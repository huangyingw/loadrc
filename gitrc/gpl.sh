#!/bin/bash
branch=`git branch |awk '/\*/{print $2}'`
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do 
  git pull $ss $branch
done
