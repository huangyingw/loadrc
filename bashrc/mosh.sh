#!/bin/bash -
target=$(echo "$1" | sed  -e "s/\/$//g")
mosh "$target" -- ${tmuxAction}
