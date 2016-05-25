#!/bin/bash
~/loadrc/gitrc/gpl.sh
. ~/loadrc/gitrc/getCurrentBranch.sh
remotes=($(git config --get-all branch."$currentBranch".remote))
if [ ${#remotes[@]} -gt 0 ]
then
  for remote in "${remotes[@]}"
  do
    git push -v $remote && git push -v --tag $remote
  done
fi 
git push -v dropbox && git push -v --tag dropbox
