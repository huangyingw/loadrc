#!/bin/zsh

~/loadrc/gitrc/discard_unnecessaries.sh

if [ -n "$(git status --untracked-files=no --porcelain --ignore-submodules)" ]
then
    return
fi

~/loadrc/gitrc/include_gitconfig.sh
git remote update
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

for remote in $(git remote)
do
    git pull $remote $currentBranch
    git remote prune $remote
done

for ss in $(git config --get-all merge.from)
do
    git merge "$ss"
done

target=$(git config gsync.target)

if [ -n "$target" ]
then
    git merge "$target"
fi
