#!/bin/zsh

COMMAND=$(~/loadrc/gitrc/git_diff_command.sh)

if [ -z "$1" ]
then
    COMMAND="$COMMAND --cached HEAD"
else
    COMMAND="$COMMAND $1 $2"
    IFS=$'\n'

    for ss in $(git config --get-all gdio.ignore)
    do
        COMMAND="$COMMAND  ':(exclude)$ss'"
    done
fi

if [[ -n "$3" ]] && [[ "$3" = "gdit" ]]
then
    for ss in $(git config --get-all gdit.ignore)
    do
        COMMAND="$COMMAND  ':(exclude)$ss'"
    done
fi

eval "$COMMAND" | sed 's/^--- a\//--- \.\//g;s/^+++ b\//+++ \.\//g;/^index [0-9a-f]*[0-9a-f]*/d'
