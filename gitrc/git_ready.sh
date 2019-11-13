#!/bin/bash -
git diff --quiet --ignore-submodules HEAD && \
    git status | grep -q 'up to date with' && \
    echo "git ready"
