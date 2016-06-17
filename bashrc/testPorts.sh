#!/bin/bash - 
host="$1"
portList="$2"
while read port
do
  nc -zv "$host" "$port"
done < "$portList"
