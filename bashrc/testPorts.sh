#!/bin/zsh
portList="$HOME/Dropbox/loadrc/bashrc/portList"
while read -r line || [[ -n "$line" ]]
do
    while read port
    do
        echo "port listening --> $port"
        ssh -n "$line" "nohup nc -l $port &" &
    done < "$portList"
    while read port
    do
        echo "port requesting --> $port"
        nc -zv "$line" "$port"
    done < "$portList"
done < servers.list
