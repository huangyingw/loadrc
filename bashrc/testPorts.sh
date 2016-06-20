#!/bin/bash - 
portList="$HOME/Dropbox/loadrc/bashrc/portList"
while read port
do
  echo "port listening --> $port"
  $HOME/loadrc/bashrc/rssh.sh "$1" "sudo nc -l $port" &
done < "$portList"
while read port
do
  echo "port requesting --> $port"
  nc -zv "$1" "$port" &
done < "$portList"
