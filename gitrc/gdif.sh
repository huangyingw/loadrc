#!/bin/bash
if [ -n "$1" ];
then
  if [ -n "$2" ];
  then
    git diff --name-status "$1" "$2"
  else
    git diff --name-status "$1"
  fi
else
  if (git status|grep -q 'nothing to commit')
  then
    git diff --name-status `git log --oneline|awk 'NR==2{print $1}'`
  else
    git diff --name-status
  fi
fi
