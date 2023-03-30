#! /bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")
tmuxAction="$(ssh "$target" ". ~/loadrc/.pathrc ; which tmux") new-session -A -s ssh"

while true
do
    ssh -Y "$target" -t -- ${tmuxAction}
    echo "Connection lost. Retrying in 3 minutes..."
    sleep 180
done
