#!/bin/bash
target=$(echo "$1" | sed  -e "s/\/$//g")

MOSHSERVER=$(ssh "$target" ". ~/loadrc/.pathrc ; which mosh-server")
tmuxAction="$(ssh "$target" ". ~/loadrc/.pathrc ; which tmux") new-session -A -s mosh"

if ( nc -vz "$target" 22 2>&1 | grep -q succeeded ) && [ -z "$MOSHSERVER" ] || [ -z "$tmuxAction" ]
then
    echo -e "${red}please check connection, mosh and tmux setting of $target first... ${NC}"
    exit 1
fi

while true
do
    ssh -fnN -R 2224:localhost:2224 "$target" &
    ssh -fnN -R 2225:localhost:2225 "$target" &
    ssh "$target" ". ~/loadrc/.pathrc ; ~/loadrc/macosrc/configure_mosh.sh" &
    mosh --server="$MOSHSERVER" "$target" -- ${tmuxAction}
done
