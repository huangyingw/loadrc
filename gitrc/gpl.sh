#!/bin/zsh

if [ -n "$(git status --porcelain)" ]
then
    return
fi

~/loadrc/gitrc/include_gitconfig.sh
git remote update &
~/loadrc/gitrc/discard_unnecessaries.sh
git pull &
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do
    git pull $ss $currentBranch &
    git remote prune $ss &
done

for ss in $(git config --get-all pull.from)
do
    COMMAND="git merge $ss &"
    eval "$COMMAND"
done

target=$(git config gsync.target)

if [ -n "$target" ]
then
    git merge "$target" &
fi
