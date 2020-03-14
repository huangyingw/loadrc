#! /bin/zsh
target=$(echo "$1" | sed  -e "s/\/$//g")

if ( ssh "$target" "uname" | grep -q Darwin )
then
    tmuxAction='/usr/local/bin/tmux new-session -A -s main'
else
    tmuxAction='/usr/bin/tmux new-session -A -s main'
fi

ssh -Y "$target" -t -- ${tmuxAction}
