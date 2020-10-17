#!/bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")
if [ -z "$1" ]
then
    ssh movie "~/loadrc/bashrc/sleep.sh"
fi
ssh "$target" "~/loadrc/bashrc/sleep.sh"
