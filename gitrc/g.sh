#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh
commit_message=$(~/loadrc/gitrc/getCommit_message.sh "$1") 

if [ -n "$commit_message" ]
then
    git commit  --no-verify -m "$commit_message"
fi
. ~/loadrc/gitrc/postCommit.sh
