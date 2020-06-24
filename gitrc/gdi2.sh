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

target_branch=$(echo "$currentBranch" | sed 's/\.fix$//g')

if [ -z $(git config gsync.remote) ]
then
    echo -e "${red}gsync.remote is not configured ... ${NC}"
fi

host=$(git config deploy.host)
rpath=$(git config deploy.path)
local_master="$(git config gsync.branch)"
remote="$(git config gsync.remote)"

GDITDIFF=$(echo "$currentBranch.gdit.diff" | sed 's/\//_/g')
git checkout -b "$target_branch" "$local_master" ; \
    git checkout files.proj ; \
    git checkout "$target_branch" ; \
    git apply --reject --whitespace=fix "$GDITDIFF" ; \
    ~/loadrc/gitrc/checkout_rejs.sh "$currentBranch" && \
    git add . && \
    git commit  --no-verify -am "$commit_message" ; \
    git push "$remote" ; \
    . ~/loadrc/imvurc/ghypo.sh "$target_branch"

~/loadrc/gitrc/gfix.sh
