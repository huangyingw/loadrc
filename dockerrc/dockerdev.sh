#!/bin/bash - 
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
#cd "$SCRIPTPATH"
cp -nv \
    ~/myproject/git/docker/dbuntu/Dockerfile \
    ~/myproject/git/docker/dbuntu/docker-compose.yml \
    ~/myproject/git/docker/dbuntu/entrypoint.sh \
    ./
