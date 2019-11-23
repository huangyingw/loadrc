#!/bin/zsh
#The first hash in the range is the oldest commit and the last hash in the range is the newest
oldest="$1"
newest="$2"
git cherry-pick "$oldest"^.."$newest"
