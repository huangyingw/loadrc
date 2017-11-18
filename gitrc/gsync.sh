#!/bin/bash
. ~/loadrc/gitrc/getCurrentBranch.sh
git co $currentBranch
git config --local include.path $(realpath .gitconfig)
git pull $(git config gsync.remote) $(git config gsync.branch)
exit 0
