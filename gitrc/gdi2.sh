#!/bin/bash -
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

if [[ "$currentBranch" != *".fix" ]]
then
    echo -e "${red} should only run in *.fix branch... ${NC}"
    exit 1
fi

commit_message=$(cat .git/COMMIT_EDITMSG)
if [ -z "$commit_message" ]
then
    echo -e "${red}Must provide the commit message ... ${NC}"
    echo -e "${red}Please edit .git/COMMIT_EDITMSG to provide commit message ... ${NC}"
    exit 1
fi

targetBranch=$(echo "$currentBranch" | sed 's/\.fix$//g')

if [ -z $(git config gsync.remote) ]
then
    echo -e "${red}gsync.remote is not configured ... ${NC}"
fi

host=$(git config deploy.host)
path=$(git config deploy.path)

~/loadrc/gitrc/gsync.sh && \
    git remote update && \
    git branch -D "$targetBranch" ; \
    git branch "$targetBranch" $(git config gsync.remote)"/"$(git config gsync.branch) && \
    ~/loadrc/gitrc/gdi.sh "$targetBranch"  2>&1 | tee gdi.findresult && \
    git co "$targetBranch" && \
    ~/loadrc/gitrc/gsync.sh && \
    git apply --reject --whitespace=fix gdi.findresult ; \
    ~/loadrc/gitrc/checkout_rejs.sh "$currentBranch" && \
    git commit  --no-verify -am "$commit_message" && \
    > .git/COMMIT_EDITMSG && \
    git push -f && \
    . ~/loadrc/imvurc/ghypo.sh "$targetBranch" && \
    ~/loadrc/gitrc/gfix.sh
