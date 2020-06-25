#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh
git commit --no-edit || \
    git commit -m n

~/loadrc/gitrc/postCommit.sh
