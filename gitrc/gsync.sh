#!/bin/bash
TARGET_BRANCH=$(git config gsync.branch)
echo "$TARGET_BRANCH"
~/loadrc/gitrc/gme.sh "$TARGET_BRANCH"
