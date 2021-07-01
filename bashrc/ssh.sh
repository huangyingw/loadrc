#! /bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")

if ( ssh "$target" "uname" | grep -q Darwin )
then
    tmuxAction='/usr/local/bin/tmux new-session -A -s ssh'
else
    tmuxAction='/usr/bin/tmux new-session -A -s ssh'
fi

ssh -Y "$target" -t -- ${tmuxAction}
