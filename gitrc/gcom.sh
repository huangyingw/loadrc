#!/bin/bash
old_branch=`git branch |awk '/^\*/{print $2}'`
echo $old_branch
git checkout "$1" \
  && git merge "$old_branch"
