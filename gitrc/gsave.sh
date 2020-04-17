#!/bin/zsh
git stash \
    && git stash apply stash@{0}
