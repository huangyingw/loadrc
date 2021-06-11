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

if [ -z $(git config gsync.remote) ]
then
    echo -e "${red}gsync.remote is not configured ... ${NC}"
fi

host=$(git config deploy.host)
rpath=$(git config deploy.path)

GDITDIFF=$(echo "$currentBranch.gdit.diff" | sed 's/\//_/g')
    ~/loadrc/gitrc/discard_unnecessaries.sh ; \
    git checkout -f "$targetBranch" ; \
    git apply --index --reject --whitespace=fix "$GDITDIFF" && \
    ~/loadrc/gitrc/checkout_rejs.sh "$currentBranch" && \
    git commit  --no-verify -am "$commit_message" ; \
    git pull ; \
    git push ; \
    . ~/loadrc/imvurc/ghypo.sh "$targetBranch" ; \
    ~/loadrc/gitrc/gfix.sh
