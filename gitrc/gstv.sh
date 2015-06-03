#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
fix_branch=`git branch |awk '/^\*/{print $2}'`
if [ -n "$1" ];
then
  git difftool stash@{"$1"}^!
  exit 0
fi
git difftool stash@{0}^!
touch gstv.ready
