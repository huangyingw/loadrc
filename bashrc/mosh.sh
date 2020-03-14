#!/bin/bash
target=$(echo "$1" | sed  -e "s/\/$//g")
mkdir "$target"

if ( ssh "$target" "uname" | grep -q Darwin )
then
    server="/usr/local/bin/mosh-server"
else
    server="/usr/bin/mosh-server"
fi

if ( ssh "$target" "uname" | grep -q Darwin )
then
    tmuxAction='/usr/local/bin/tmux new-session -A -s main'
else
    tmuxAction='/usr/bin/tmux new-session -A -s main'
fi

mosh --server="$server" "$target" -- ${tmuxAction}
