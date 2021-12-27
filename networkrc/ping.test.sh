#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./ping.sh
rc=$?

if [[ $rc -eq 0 ]] ; then                # Make final determination.
    echo "say The internet is back up."
else
    echo "say Timeout."
fi
