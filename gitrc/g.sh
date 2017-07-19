#!/bin/bash
worktree=$(pwd)
worktree=`echo "$worktree" | sed  -e "s/\.git//g;s/modules\///g"`
cd "$worktree"
git config --local include.path "$worktree/.gitconfig"
. ~/loadrc/gitrc/getCommit_message.sh "$1"
git commit  --no-verify -m "$commit_message"
~/loadrc/gitrc/postCommit.sh
