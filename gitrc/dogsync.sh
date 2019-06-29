#!/bin/bash -
~/loadrc/gitrc/include_gitconfig.sh
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)
git remote update

for ss in $(git config --get-all pull.from)
do
    remote_branch=$(echo "$ss" | sed  -e "s/\// /g")
    COMMAND="git pull $remote_branch"
    eval "$COMMAND"
done

if [ -n $(git config gsync.remote) ]
then
    git fetch $(git config gsync.remote) $(git config gsync.branch):$(git config gsync.branch)
    git merge $(git config gsync.branch) "$currentBranch"
else
    git pull
fi
