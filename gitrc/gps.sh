#!/bin/bash
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

if ( echo $currentBranch | grep -q 'fix$' )
then
    exit 1
fi

~/loadrc/gitrc/gpl.sh
~/loadrc/gitrc/include_gitconfig.sh

if [[ $(git config --get-all push.remote) ]]
then
    for ss in $(git config --get-all push.remote)
    do
        git push -v "$ss" && git push -v --tag "$ss"
    done
fi

git push -v BareReps && git push -v --tag BareReps
