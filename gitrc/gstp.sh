#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
fix_branch=`git branch |awk '/^\*/{print $2}'`
if [ -n "$1" ];
then
  git stash pop stash@{"$1"}
  exit 0
fi
if ! (git status|grep -q 'nothing to commit')
then
  echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
  exit 1
fi
#if  ( echo $fix_branch|grep -q 'fix$' )
#then
#  echo -e "${red}gstp should not be run in fix branch ... ${NC}"
#  exit 1
#fi 
top_branch=`git stash list|awk 'NR==v1 {print $4}' v1=$(($1+1)) |sed 's/://g'`
echo $top_branch
git branch |awk '/^\*/{print $2}'
~/loadrc/gitrc/gco.sh $top_branch
git stash pop
