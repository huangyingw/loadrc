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

if [ -z "$1" ]
then
    COMMAND="$COMMAND --cached HEAD"
else
    COMMAND="$COMMAND $1 $2"
    IFS=$'\n'

    for ss in $(git config --get-all gdio.ignore)
    do
        ss=${ss//\"/\\\"}
        COMMAND="$COMMAND \":(exclude)$ss\""
    done
fi

if [[ -n "$3" ]] && [[ "$3" = "gdit" ]]
then
    for ss in $(git config --get-all gdit.ignore)
    do
        ss=${ss//\"/\\\"}
        COMMAND="$COMMAND \":(exclude)$ss\""
    done
fi

scope_path=$(git config --get scope.path)

if [[ -n "$scope_path" ]]
then
    COMMAND="$COMMAND -- \"$scope_path\""
else
    COMMAND="$COMMAND -- :/"
fi

# Save the current options
SAVED_OPTS=$(setopt | grep NOMATCH)
# Temporarily disable filename expansion
setopt LOCAL_OPTIONS NO_NOMATCH

# Run the command without stderr output
diff_output=$(eval "$COMMAND" 2>/dev/null)

# Restore the previous options
if [[ -n "$SAVED_OPTS" ]]; then setopt $SAVED_OPTS; else unsetopt NOMATCH; fi

# Process the diff output
echo "$diff_output" | sed 's/^--- a\//--- \.\//g;s/^+++ b\//+++ \.\//g;/^index [0-9a-f]*[0-9a-f]*/d'
