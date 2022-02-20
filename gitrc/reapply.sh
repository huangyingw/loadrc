#!/bin/zsh
DIFF="$1"

cp -fv "$DIFF" "$DIFF".bak
~/loadrc/gitrc/restore.sh
cp -fv "$DIFF".bak "$DIFF"

git apply --reject --whitespace=fix --recount "$DIFF" || \
    echo "git apply failed" && \
    exit 1
