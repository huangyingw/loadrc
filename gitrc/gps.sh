#!/bin/zsh
~/loadrc/gitrc/include_gitconfig.sh

if [[ $(git config --get-all push.remote) ]]
then
    for ss in $(git config --get-all push.remote)
    do
        git push --all -v "$ss"
        git push -v --tag "$ss"
    done
fi
