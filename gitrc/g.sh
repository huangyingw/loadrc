#!/bin/bash
current_branch=`git branch |awk '/^\*/{print $2}'`
commit_message=""
if  [ -z "$(git status --porcelain)" ]
then
  commit_message="n"
fi 
if ( echo $current_branch | grep -q 'fix$' )
then
  commit_message="n"
fi 
if [ -n "$1" ]
then
  commit_message="$1"
fi
if [ -n "$(cat .git/COMMIT_EDITMSG)" ]
then
  commit_message=$(cat .git/COMMIT_EDITMSG)
  > .git/COMMIT_EDITMSG
fi
if [ -f .git/MERGE_MSG ]
then
  commit_message=$(cat .git/MERGE_MSG |awk 'NR==1')
fi
if [ -z "$commit_message" ]
then
  echo -e "${red}Must provide the commit message ... ${NC}"
  exit 1
fi
git commit  --no-verify -m "$commit_message"
~/loadrc/gitrc/gclb.sh
~/loadrc/gitrc/gsync.sh              
~/loadrc/gitrc/gps.sh
