#! /bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")
tmuxAction="$(ssh "$target" ". ~/loadrc/.pathrc ; which tmux") new-session -A -s ssh"
ssh -fnN -R 2224:localhost:2224 "$target" &
ssh -fnN -R 2225:localhost:2225 "$target" &
ssh -Y "$target" -t -- ${tmuxAction}
