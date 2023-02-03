#!/bin/zsh
repo=$(echo "$1" | sed 's/.*\/\([^\/]*\)\.git/\1/g')
author=$(echo "$1" | sed 's/.*[:/]\([^\/]*\)\/[^\/]*\.git/\1/g')
echo "repo --> $repo"
echo "author --> $author"
