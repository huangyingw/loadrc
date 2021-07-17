#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh

if [ -f COMMIT_EDITMSG ]
then
    commit_message=$(cat COMMIT_EDITMSG)
fi

if [ -n "$1" ]
then
    commit_message="$1"
fi

if [ -z "$commit_message" ]
then
    commit_message="n"
fi

git commit --no-edit || \
    git commit -m "$commit_message"

~/loadrc/gitrc/postCommit.sh
