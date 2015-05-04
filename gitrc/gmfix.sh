#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
fix_branch=`git branch |awk '/^\*/{print $2}'`
previous_branch=`echo ${fix_branch} | sed -e "s|.fix$||"` 
echo $fix_branch
echo $previous_branch
if [ ! -f gfvd.already ];
then
  echo -e "${red}gfvd must be run before gmfix first ... ${NC}"
  exit 1
fi
if  ( ! echo $fix_branch|grep -q 'fix$' )
then
  echo -e "${red}It must be run in fix branch ... ${NC}"
  exit 1
fi 
git checkout $previous_branch \
  && git merge $fix_branch \
  && git branch -d $fix_branch \
  && for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push $ss :$fix_branch; done
rm gfvd.already
