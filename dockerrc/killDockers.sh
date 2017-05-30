#!/bin/bash -

docker kill $(docker ps -q)
docker ps -a | awk '{print $1}' | xargs docker rm
