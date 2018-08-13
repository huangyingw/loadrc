#!/bin/bash -
current_branch=$(~/loadrc/gitrc/get_current_branch.sh)
commit_message=""

if [ -z "$(git status --porcelain)" ]
then
    commit_message="n"
fi

~/loadrc/gitrc/include_gitconfig.sh
commit_message=$(git config commit.message)

if [ -n "$1" ]
then
    commit_message="$1"
fi

cd $(~/loadrc/gitrc/get_index.sh $pwd)/../

if [ -n "$(cat .git/COMMIT_EDITMSG)" ]
then
    commit_message=$(cat .git/COMMIT_EDITMSG)
fi

if [ -f .git/MERGE_MSG ]
then
    commit_message=$(cat MERGE_MSG |awk 'NR==1')
fi

if [ -z "$commit_message" ]
then
    echo -e "${red}Must provide the commit message ... ${NC}"
    exit 1
fi

cd -
