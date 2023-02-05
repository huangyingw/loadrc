#!/bin/zsh

DIFF="$1"
cp -fv "$DIFF" "$DIFF".tmp
clean=$(git status --porcelain)

if [ -n "$clean" ]
then
    git stash
fi

~/loadrc/gitrc/restore.sh
cp -fv "$DIFF".tmp "$DIFF"

git apply --reject --whitespace=fix --recount --allow-empty "$DIFF" || \
    echo "git apply failed" && \
    exit 1

if [ -n "$clean" ]
then
    git stash pop stash@{0}
fi
