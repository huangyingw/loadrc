#!/bin/bash
#~/loadrc/gitrc/gpl.sh
#for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push -v $ss && git push -v --tag $ss; done
. ~/loadrc/gitrc/getCurrentBranch.sh
remotes=($(git config --get-all branch."$currentBranch".remote))
echo ${remotes[@]}
