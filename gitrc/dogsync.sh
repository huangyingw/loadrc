#!/bin/bash -
~/loadrc/gitrc/include_gitconfig.sh

if [ -n $(git config gsync.remote) ]
then
    git pull $(git config gsync.remote) $(git config gsync.branch)
else
    git pull
fi
