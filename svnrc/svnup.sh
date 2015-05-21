#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -n "$1" ];
then
  folderForGit="$1"
else
  folderForGit=.
fi
if  ( git status "$folderForGit"|grep -q 'nothing to commit' )
then
  svn up
  git st
else
  echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
  exit 1
fi
