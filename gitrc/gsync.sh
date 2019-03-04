#!/bin/bash
~/loadrc/gitrc/include_gitconfig.sh

doGsync () {
    if [ -n $(git config gsync.remote) ]
    then
        git pull $(git config gsync.remote) $(git config gsync.branch)
    else
        git pull
    fi
}
export -f doGsync

doGsync
git submodule foreach bash -c 'doGsync || :'
