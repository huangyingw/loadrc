#!/bin/bash - 
host="$1"
portList="$HOME/Dropbox/loadrc/bashrc/portList"
while read port
do
  nc -zv "$host" "$port" | tee testPorts.findresult
  nc -zuv "$host" "$port" | tee testPorts.findresult 
done < "$portList"
