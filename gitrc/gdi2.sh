#!/bin/bash -
if [ -z "$1" ]
then
    echo -e "${red}Please provide branch name ... ${NC}"
fi

if [ -z $(git config gsync.remote) ]
then
    echo -e "${red}gsync.remote is not configured ... ${NC}"
fi

branch="$1"
git branch -D "$branch"
git branch "$branch" $(git config gsync.remote)"/"$(git config gsync.branch)
~/loadrc/gitrc/gdi.sh "$branch"  2>&1 | tee gdi.findresult && \
    git co "$branch" && \
    ~/loadrc/gitrc/gsync.sh && \
    git apply --reject --whitespace=fix gdi.findresult && \
    ~/loadrc/gitrc/gwap.sh
