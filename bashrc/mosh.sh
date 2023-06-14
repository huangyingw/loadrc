#!/bin/bash
target=$(echo "$1" | sed -e "s/\/$//g")

MOSHSERVER=$(ssh "$target" ". ~/loadrc/.pathrc ; which mosh-server")
tmuxAction="$(ssh "$target" ". ~/loadrc/.pathrc ; which tmux") new-session -A -s mosh"

ssh "$target" ". ~/loadrc/.pathrc ; ~/loadrc/macosrc/configure_mosh.sh" &

while true; do
    mosh --server="$MOSHSERVER" "$target" -- ${tmuxAction}
    echo "Connection lost. Retrying in 5 seconds..."
    sleep 5
done
