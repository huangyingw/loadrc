#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
current_branch=`git branch |awk '/^\*/{print $2}'`
up_branch=`echo ${current_branch} | sed 's/\(\.[^.]*\)$//'`
echo $current_branch
echo $up_branch
if  ( echo $current_branch|grep -q 'fix$' )
then
  echo -e "${red}Please use gmfix to merge fix branch ... ${NC}"
  exit 1
fi 
if [ $current_branch == $up_branch ];
then
  echo -e "${red}It is already top branch ... ${NC}"
  exit 1
fi
git checkout $up_branch \
  && git merge $current_branch
