#!/bin/bash -

host=$(git config deploy.host)
path=$(git config deploy.path)

if [[ -n "$host" ]] && [[ -n "$path" ]]
then
    ~/loadrc/bashrc/rsync.sh "$host:$path"
fi
