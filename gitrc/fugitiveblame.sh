#!/bin/zsh
COMMIT="$1"
git bisect start
~/loadrc/gitrc/discard_unnecessaries.sh
git diff --quiet && \
    git diff HEAD --quiet && \
    git checkout -f "$COMMIT^"
