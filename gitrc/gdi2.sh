#!/bin/zsh
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

if [[ "$currentBranch" != *".fix" ]]
then
    echo -e "${red} should only run in *.fix branch... ${NC}"
    exit 1
fi

commit_message=$(cat COMMIT_EDITMSG)

if [ -z "$commit_message" ]
then
    echo -e "${red}Must provide the commit message ... ${NC}"
    echo -e "${red}Please edit COMMIT_EDITMSG to provide commit message ... ${NC}"
    exit 1
fi

targetBranch=$(echo "$currentBranch" | sed 's/\.fix$//g')

if [ -z $(git config gsync.target) ]
then
    echo -e "${red}gsync.target is not configured ... ${NC}"
fi

host=$(git config deploy.host)
rpath=$(git config deploy.path)

remote="$(git config gsync.remote)"

git push "$remote" "$targetBranch"

GDITDIFF=$(echo "$currentBranch.gdit.diff" | sed 's/\//_/g')

if [ -z $(cat $GDITDIFF) ]
then
    exit 0
fi

~/loadrc/gitrc/discard_unnecessaries.sh ; \
    git checkout -f "$targetBranch" ; \
    git apply --reject --whitespace=fix --recount --index "$GDITDIFF"

retVal=$?

if [ $retVal -ne 0 ]
then
    ~/loadrc/gitrc/checkout_rejs.sh "$currentBranch" "$1"
fi

if [ $retVal -eq 0 ] || [ "$1" = "f" ]
then
    git commit  --no-verify -am "$commit_message" && \
        git pull ; \
        git push ; \
        ~/loadrc/gitrc/gfix.sh
fi
