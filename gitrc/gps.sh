#!/bin/bash
chmod 400 ~/.ssh/id_rsa
~/loadrc/gitrc/gpl.sh

~/loadrc/gitrc/include_gitconfig.sh
if [[ $(git config --get-all push.remote) ]]
then
    for ss in $(git config --get-all push.remote)
    do
        git push -v "$ss" && git push -v --tag "$ss"
    done
else
    for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push -v "$ss" && git push -v --tag "$ss"; done
fi

git push -v BareReps && git push -v --tag BareReps
