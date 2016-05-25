#!/bin/bash
~/loadrc/gitrc/gpl.sh
. ~/loadrc/gitrc/getCurrentBranch.sh
remotes=($(git config --get-all branch."$currentBranch".remote))
for remote in "${remotes[@]}"
do
  git push -v $remote && git push -v --tag $remote
done
git push -v dropbox && git push -v --tag dropbox
