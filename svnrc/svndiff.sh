#!/bin/zsh
fullfile="$1"
if [ $(basename "$fullfile") = "index" ]
then
    svn diff -x -w --cl utest > svn.diff
else
    svn diff --diff-cmd kdiff3 "$fullfile"
fi
