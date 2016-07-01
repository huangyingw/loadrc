#!/bin/bash
. ~/loadrc/gitrc/getCurrentBranch.sh
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do 
  git pull $ss $currentBranch
done
