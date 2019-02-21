#!/bin/bash -
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

if [[ "$currentBranch" != *".fix" ]]
then
    echo -e "${red} should only run in *.fix branch... ${NC}"
    exit 1
fi

if [ -z "$1" ]
then
    targetBranch=$(echo "$currentBranch" | sed 's/\.fix$//g')
fi

if [ -z $(git config gsync.remote) ]
then
    echo -e "${red}gsync.remote is not configured ... ${NC}"
fi

git branch -D "$targetBranch"
git branch "$targetBranch" $(git config gsync.remote)"/"$(git config gsync.branch)
~/loadrc/gitrc/gdi.sh "$targetBranch"  2>&1 | tee gdi.findresult && \
    git co "$targetBranch" && \
    ~/loadrc/gitrc/gsync.sh && \
    git apply --reject --whitespace=fix gdi.findresult
~/loadrc/gitrc/checkout_rejs.sh "$currentBranch" && \
    ~/loadrc/gitrc/gwap.sh
