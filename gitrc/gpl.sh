#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh
git remote update
git checkout files.proj *.gdio.diff
git pull
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do
    git pull $ss $currentBranch
done

for ss in $(git config --get-all pull.from)
do
    remote_branch=$(echo "$ss" | sed  -e "s/\// /g")
    COMMAND="git pull $remote_branch"
    eval "$COMMAND"
done

if [ -n $(git config gsync.remote) ]
then
    git pull $(git config gsync.remote) $(git config gsync.branch)
fi
