#! /bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")
tmuxAction="$(ssh "$target" ". ~/loadrc/.pathrc ; which tmux") new-session -A -s ssh"

ssh -Y "$target" -t -- ${tmuxAction}
