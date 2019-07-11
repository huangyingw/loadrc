#!/bin/bash -

host=$(git config deploy.host)
path=$(git config deploy.path)

if [ "$host" == "localhost" ]
then
    exit 0
fi

if [[ -n "$host" ]] && [[ -n "$path" ]]
then
    ssh -n "$host" "mkdir -p $path"
    . ~/loadrc/bashrc/rsyncFiles.sh . "$host:$path"
fi
