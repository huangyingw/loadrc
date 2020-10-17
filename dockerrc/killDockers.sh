#!/bin/zsh

docker kill $(docker ps -q)
docker ps -a | awk 'NR > 1 {print $1}' | xargs docker rm
