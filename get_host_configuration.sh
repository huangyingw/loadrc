#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

find hosts/`hostname`/ -type f | while read ss; \
do \
    sudo cp -fv "/$(echo "$ss" | sed "s/hosts\/`hostname`\///g")" "$ss"; \
done
