#!/bin/bash
current_branch=`git branch |awk '/^\*/{print $2}'`
if  ( echo $current_branch|grep -q 'fix$' )
then
  echo -e "${red}gfix should not be run in fix branch ... ${NC}"
  exit 1
fi 
fix_branch=`git branch |awk '/^\*/{print $2}'`.fix
echo $fix_branch
git branch -d $fix_branch
git checkout -b $fix_branch
