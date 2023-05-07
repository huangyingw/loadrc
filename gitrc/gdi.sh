#!/bin/zsh

if [[ -n "$3" ]] && [[ "$3" = "gdit" ]]
then
    COMMAND="git diff \
    --binary \
    --ignore-blank-lines \
    --ignore-cr-at-eol \
    --minimal"
else
    COMMAND=$(~/loadrc/gitrc/git_diff_command.sh)
fi

scope_path=$(git config --get scope.path)

if [ -z "$1" ]
then
    COMMAND="$COMMAND --cached HEAD"
else
    if [[ -n "$scope_path" ]]
    then
        COMMAND="$COMMAND -- $scope_path"
    fi

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
