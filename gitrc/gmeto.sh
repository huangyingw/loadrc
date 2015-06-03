#!/bin/bash
CURRENT_BRANCH="`git branch |awk '/^\*/{print $2}'`"
TARGET_BRANCH=`echo ${CURRENT_BRANCH} | sed -e "s|.fix$||"` 
if [ -n "$1" ];
then
  TARGET_BRANCH="$1"
fi
echo "$TARGET_BRANCH"
if  ( git status|grep -q 'nothing to commit' )
then
  git checkout "$TARGET_BRANCH" \
    && git merge "$CURRENT_BRANCH" \
    && git checkout "$CURRENT_BRANCH"
else
  git add . \
    && git stash|grep -q "HEAD is now at" \
    && git checkout "$TARGET_BRANCH" \
    && git merge "$CURRENT_BRANCH" \
    && git checkout "$CURRENT_BRANCH" \
    && git stash pop stash@{0} \
    && git reset HEAD . 
fi 
