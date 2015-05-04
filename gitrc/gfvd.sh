#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
fix_branch=`git branch |awk '/^\*/{print $2}'`
previous_branch=`echo ${fix_branch} | sed -e "s|.fix$||"` 
echo $fix_branch
echo $previous_branch
if  ( ! echo $fix_branch|grep -q 'fix$' )
then
  echo -e "${red}It must be run in fix branch ... ${NC}"
  exit 1
fi 
git vd $previous_branch
touch gfvd.already
