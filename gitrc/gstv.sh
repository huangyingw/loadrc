#!/bin/bash
fix_branch=`git branch |awk '/^\*/{print $2}'`
if [ -n "$1" ]
then
    git difftool stash@{"$1"}^!
    exit 0
fi
git difftool stash@{0}^!
touch gstv.ready
