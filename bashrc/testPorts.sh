#!/bin/bash - 
portList="$HOME/Dropbox/loadrc/bashrc/portList"
while read port
do
  $HOME/loadrc/bashrc/rssh.sh "$1" "nc -l $port"
  nc -zv "$1" "$port" | tee testPorts.findresult
  $HOME/loadrc/bashrc/rssh.sh "$1" "nc -lu $port"
  nc -zuv "$1" "$port" | tee testPorts.findresult 
done < "$portList"
