#!/bin/zsh

while read host
do
    for port in \
        2224 \
        2225
    do
        ssh -fnN -R "$port":localhost:"$port" "$host" &
    done
done < ~/loadrc/bashrc/ports_forward.hosts
