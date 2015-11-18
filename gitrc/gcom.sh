#!/bin/bash
old_branch=`git branch |awk '/^\*/{print $2}'`
echo $old_branch
if  ( git status|grep -q 'nothing to commit' )
then
  git checkout "$1" \
    && ~/loadrc/gitrc/gme.sh "$old_branch"
else
  git add . \
    && git stash|grep -q "HEAD is now at" \
    && git checkout "$1" \
    && ~/loadrc/gitrc/gme.sh "$old_branch" \
    && git stash pop stash@{0} \
    && git reset HEAD . 
fi 
