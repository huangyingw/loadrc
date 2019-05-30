#!/bin/bash -
~/loadrc/gitrc/include_gitconfig.sh
git remote update

for ss in $(git config --get-all gsync.remote)
do
    remote_branch=$(echo "$ss" | sed  -e "s/\// /g")
    COMMAND="git pull $remote_branch"
    eval "$COMMAND"
done

git pull
