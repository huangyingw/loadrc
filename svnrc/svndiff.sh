#!/bin/bash
fullfile="$1"
if [ $(basename "$fullfile") == "index" ]
then
    svn diff --cl utest > utest.diff
else
    svn diff --diff-cmd kdiff3 "$fullfile"
fi
