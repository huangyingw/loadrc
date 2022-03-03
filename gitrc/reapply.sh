#!/bin/zsh
DIFF="$1"

cp -fv "$DIFF" "$DIFF".tmp
~/loadrc/gitrc/restore.sh
cp -fv "$DIFF".tmp "$DIFF"

git apply --reject --whitespace=fix --recount "$DIFF" || \
    echo "git apply failed" && \
    exit 1
