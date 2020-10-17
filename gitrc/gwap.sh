#!/bin/zsh
git reset HEAD && \
    git diff -w --no-color | \
    git apply --cached --ignore-whitespace
