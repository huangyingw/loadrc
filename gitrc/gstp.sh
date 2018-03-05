#!/bin/bash
if [ -z "$1" ]
then
    echo -e "${red}please specify the stash index ... ${NC}"
    exit 1
fi
git stash show -p stash@{"$1"} | git apply && git stash drop stash@{"$1"}
