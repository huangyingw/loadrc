#!/bin/bash
if [ -n "$1" ]
then
    git stash pop stash@{"$1"}
    exit 0
fi
~/loadrc/gitrc/checkGitStatus.sh
if [ $? -ne 0 ]
then
    exit 1
fi
top_branch=$(git stash list|awk 'NR==v1 {print $4}' v1=$(($1+1)) |sed 's/://g')
echo $top_branch
~/loadrc/gitrc/gco.sh $top_branch
git stash pop
