#!/bin/bash
GCIDEFAULT=gci.default
commit_message='n'
if [ -z "$1" ]
then
  if [ ! -f .git/MERGE_MSG ] && [ ! -f "$GCIDEFAULT" ] && [ -n "$(git status --porcelain)" ]
  then
    echo -e "${red}Must provide the commit message ... ${NC}"
    exit 1
  fi
else
  commit_message="$1"
fi
if [ -f .git/MERGE_MSG ]
then
  commit_message=$(cat .git/MERGE_MSG |awk 'NR==1')
fi
git commit  --no-verify -m "$commit_message"
~/loadrc/gitrc/gclb.sh
~/loadrc/gitrc/gsync.sh              
~/loadrc/gitrc/gps.sh
