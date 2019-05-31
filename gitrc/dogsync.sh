#!/bin/bash -
~/loadrc/gitrc/include_gitconfig.sh
git remote update

for ss in $(git config --get-all pull.from)
do
    remote_branch=$(echo "$ss" | sed  -e "s/\// /g")
    COMMAND="git pull $remote_branch"
    eval "$COMMAND"
done

if [ -n $(git config gsync.remote) ]
then
    git pull $(git config gsync.remote) $(git config gsync.branch)
else
    git pull
fi
