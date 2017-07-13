#!/bin/bash
TARGET_BRANCH=$(git config gsync.branch)
echo "$TARGET_BRANCH"
git pull "$TARGET_BRANCH"
