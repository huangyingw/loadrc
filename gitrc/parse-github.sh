#!/bin/zsh
repo=$(echo "$1" | perl -lne 'print $1 if m/([^\/:]+?)(?:\.git)?$/')
author=$(echo "$1" | perl -lne 'print $1 if m/([^\/:]+)\/[^\/:]+(?:\.git)?$/')
echo "repo --> $repo"
echo "author --> $author"
