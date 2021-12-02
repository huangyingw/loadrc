#!/bin/zsh

while [[ "$#" -gt 0 ]]
do
    case $1 in
        -r | --reverse)
            local reverse="true"
            ;;
        -b | --branch)
            local branch="$2"
            ;;
        -f | --file)
            local file="$2"
            ;;
    esac
    shift
done

COMMAND=$(~/loadrc/gitrc/git_diff_command.sh)

if [[ "$reverse" == "true" ]]
then
    COMMAND="$COMMAND HEAD $branch"
else
    COMMAND="$COMMAND $branch"
fi

while read ss
do
    COMMAND="$COMMAND  -- '$ss'"
done < "$file"

eval "$COMMAND" | sed "s/^--- a\//--- \.\//g;s/^+++ b\//+++ \.\//g"
