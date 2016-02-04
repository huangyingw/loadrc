#!/bin/bash
fix_branch=`git branch |awk '/^\*/{print $2}'`
previous_branch=`echo ${fix_branch} | sed -e "s|.fix$||"` 
echo $fix_branch
echo $previous_branch
if  ( ! echo $fix_branch|grep -q 'fix$' )
then
  echo -e "${red}It must be run in fix branch ... ${NC}"
  exit 1
fi 
touch gfvd.already
git vd $previous_branch
