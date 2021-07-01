#!/bin/zsh

~/loadrc/gitrc/include_gitconfig.sh
git remote update &
git checkout *.gdio.diff
git pull &
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do
    git pull $ss $currentBranch &
    git remote prune $ss &
done

for ss in $(git config --get-all pull.from)
do
    pull_from=$(echo "$ss" | sed  -e "s/\// /g")
    COMMAND="git pull $pull_from &"
    eval "$COMMAND"
done

remote=$(git config gsync.remote)
remote_branch=$(git config gsync.branch)

if [ -n "$remote" ]
then
    git merge "$remote"/"$remote_branch"
fi
