#!/bin/bash - 
imageName="$1"
for CONTAINERID in $(docker ps|grep "$imageName"|awk '{print $1}' )
do
  docker stop "$CONTAINERID"
  docker rm "$CONTAINERID"
done
