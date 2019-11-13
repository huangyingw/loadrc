#!/bin/bash -
git diff --quiet --ignore-submodules HEAD && \
    git status | grep -q 'up to date with' && \
    exit 0
exit 1
