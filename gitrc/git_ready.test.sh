#!/bin/bash - 
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [[ $(./git_ready.sh) ]] 
then
    echo true
else
    echo false
fi
