#!/bin/zsh 
docker rmi -f $(docker images -a | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)
