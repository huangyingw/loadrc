#!/bin/bash
target=$(echo "$1" | sed  -e "s/\/$//g")
mkdir "$target"

MOSHSERVER=$(ssh "$target" ". ~/loadrc/.loadrc ; which mosh-server")
tmuxAction="$(ssh "$target" ". ~/loadrc/.loadrc ; which tmux") new-session -A -s mosh"

while true
do
    ssh -fnN -R 2224:localhost:2224 "$target" &
    ssh "$target" "~/loadrc/macosrc/configure_mosh.sh" &
    mosh --server="$MOSHSERVER" "$target" -- ${tmuxAction}
done
