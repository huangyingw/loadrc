#!/bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")

if [ -z "$1" ]
then
    ssh server "~/loadrc/bashrc/sleep.sh"
fi

ssh "$target" "~/loadrc/bashrc/sleep.sh"
