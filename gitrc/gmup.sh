#!/bin/bash
gitClean=true
if [ -n "$(git status --porcelain)" ]
then
  git stash
  gitClean=false
fi 
origin_branch=`git branch |awk '/^\*/{print $2}'`
current_branch=`git branch |awk '/^\*/{print $2}'`
up_branch=`echo ${current_branch} | sed 's/\(\.[^.]*\)$//'`
while [ $current_branch != $up_branch ]
do
  git checkout $up_branch \
    && ~/loadrc/gitrc/gme.sh $current_branch
  current_branch=$up_branch
  up_branch=`echo ${current_branch} | sed 's/\(\.[^.]*\)$//'`
done 
git checkout $origin_branch \
  && ~/loadrc/gitrc/gme.sh $up_branch
if [ "$gitClean" != "true" ]
then
  git stash pop stash@{0}
fi
