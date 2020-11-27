#!/bin/zsh

COMMAND=$(~/loadrc/gitrc/git_diff_command.sh)
COMMAND="$COMMAND HEAD $1"

while read ss
do
    COMMAND="$COMMAND  -- '$ss'"
done < "$2"

eval "$COMMAND"
