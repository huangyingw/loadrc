#!/bin/bash - 
portList="$HOME/Dropbox/loadrc/bashrc/portList"
while read port
do
  echo "port --> $port"
  $HOME/loadrc/bashrc/rssh.sh "$1" "sudo nc -l $port" &
done < "$portList"
