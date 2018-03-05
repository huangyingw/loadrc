#!/bin/bash
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)
git co $currentBranch
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do
    git pull $ss $currentBranch
done
