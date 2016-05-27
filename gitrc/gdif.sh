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
