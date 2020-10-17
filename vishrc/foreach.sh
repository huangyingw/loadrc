#!/bin/zsh
COMMAND="$2 $(<$1)"
eval "$COMMAND"
