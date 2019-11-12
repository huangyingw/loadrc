#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh
. ~/loadrc/gitrc/getCommit_message.sh "$1"
git commit  --no-verify -m "$commit_message"
. ~/loadrc/gitrc/postCommit.sh
