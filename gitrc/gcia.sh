#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if (git status|grep -q '# Changes to be committed:')
then
  echo -e "${red}should not run gcia, while there is sth to be committed ... ${NC}"
  exit 1
fi
last_message=`git log -1 --pretty=%B|awk 'NR==1'`
echo $last_message
new_message="$1,$last_message"
git commit --amend -m "$new_message"
