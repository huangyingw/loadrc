#!/bin/zsh

~/loadrc/gitrc/include_gitconfig.sh
git remote update
~/loadrc/gitrc/discard_unnecessaries.sh
git pull
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do
    git pull $ss $currentBranch
    git remote prune $ss
done

for ss in $(git config --get-all pull.from)
do
    remote_branch=$(echo "$ss" | sed  -e "s/\// /g")
    COMMAND="git pull $remote_branch &"
    eval "$COMMAND"
done

remote=$(git config gsync.remote)
branch=$(git config gsync.branch)
if [ -n "$remote" ]
then
    git branch "$branch" "$remote"/"$branch"
    git fetch "$remote" "$branch":"$branch"
    git merge "$branch"
fi
