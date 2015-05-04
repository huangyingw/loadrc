#!/bin/bash
if [ -n "$1" ];
then
  if [ -n "$2" ];
  then
    git difftool "$1" "$2"
  else
    git difftool "$1"
  fi
else
  if (git status|grep -q 'nothing to commit')
  then
    git difftool `git log --oneline|awk 'NR==2{print $1}'`
  else
    git difftool
  fi
fi
