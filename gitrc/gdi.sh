#!/bin/zsh
if [ -z "$1" ]
then
    git diff --ignore-space-at-eol -b -w --cached HEAD
else
    COMMAND="git diff --ignore-space-at-eol -b -w $1 $2"

    for ss in $(git config --get-all gdif.ignore)
    do
        COMMAND="$COMMAND  ':(exclude)$ss'"
    done

    local_branch="$(~/loadrc/gitrc/get_current_branch.sh)" 
    output="$local_branch.gdio.diff"
    COMMAND="$COMMAND  ':(exclude)$output'"

    eval "$COMMAND"
fi
