#!/bin/bash
git config --local include.path "$pwd/.gitconfig"
. ~/loadrc/gitrc/getCommit_message.sh "$1"
git commit  --no-verify -m "$commit_message"
~/loadrc/gitrc/postCommit.sh
