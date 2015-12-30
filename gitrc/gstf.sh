#!/bin/bash
fix_branch=`git branch |awk '/^\*/{print $2}'`
if [ -n "$1" ];
then
  git diff --name-status stash@{"$1"}^!
  exit 0
fi
git diff --name-status stash@{0}^!
