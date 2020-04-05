#!/bin/zsh
cd $(~/loadrc/gitrc/get_git.sh $pwd)
: > COMMIT_EDITMSG
cd -
~/loadrc/gitrc/gsync.sh
