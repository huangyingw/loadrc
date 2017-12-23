#!/bin/bash
. ~/loadrc/gitrc/getCurrentBranch.sh
git co $currentBranch
git config --local include.path $(realpath .gitconfig)
if [ -n $(git config gsync.remote) ]
then
    git pull $(git config gsync.remote) $(git config gsync.branch)
fi
exit 0
