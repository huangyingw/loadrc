#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh

commit_message="n"

if [ -f COMMIT_EDITMSG ]
then
    commit_message=$(cat COMMIT_EDITMSG)
fi

if [ -n "$1" ]
then
    commit_message="$1"
fi

git commit --no-edit || \
    git commit -m "$commit_message"

~/loadrc/gitrc/postCommit.sh
