#!/bin/zsh
git diff --quiet --ignore-submodules HEAD && \
    git status | grep -q  'up to date with\|up-to-date with' && \
    echo 1
    exit 0
echo 0
exit 1
