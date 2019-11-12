#!/bin/zsh
~/loadrc/gitrc/checkGitStatus.sh
if [ $? -ne 0 ]
then
  exit 1
fi
last_message=`git log -1 --pretty=%B|awk 'NR==1'`
echo $last_message
new_message="$1,$last_message"
git commit --amend -m "$new_message"
