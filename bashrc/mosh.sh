#!/bin/bash
target=$(echo "$1" | sed  -e "s/\/$//g")
mkdir "$target"

if ( ssh "$target" "uname" | grep -q Darwin )
then
    server="/usr/local/bin/mosh-server"
    tmuxAction='/usr/local/bin/tmux new-session -A -s mosh'
    ssh "$target" "~/loadrc/macosrc/configure_mosh.sh"
else
    server="/usr/bin/mosh-server"
    tmuxAction='/usr/bin/tmux new-session -A -s mosh'
fi

while true
do
    mosh --server="$server" "$target" -- ${tmuxAction}
done
