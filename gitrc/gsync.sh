#!/bin/bash
. ~/loadrc/gitrc/getCurrentBranch.sh
git co $currentBranch
git pull $(git config gsync.remote) $(git config gsync.branch)
