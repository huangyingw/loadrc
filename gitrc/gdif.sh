#!/bin/bash
if [ -n "$1" ];
then
  if [ -n "$2" ];
  then
    git diff --name-status "$1" "$2" | tee gdif.findresult 
  else
    git diff --name-status "$1" | tee gdif.findresult  
  fi
else
  if [ -z "$(git status --porcelain)" ]
  then
    git diff --name-status `git log --oneline|awk 'NR==2{print $1}'` | tee gdif.findresult  
  else
    git diff --name-status | tee gdif.findresult  
  fi
fi
OS=`uname`
if [ "$OS" == "Linux" ]
then
  xargs sed -i"" "s/\bA\b/git\srm/g" < gdif.findresult
else
  sed -i.bak "s/[[:<:]]A[[:>:]]/git rm/g" gdif.findresult 
fi
