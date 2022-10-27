#!/bin/zsh

for port in \
    2224 \
    2225
do
    ssh -fnN -R "$port":localhost:"$port" "$1" &
done
