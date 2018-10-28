#!/bin/bash -

host=$(git config deploy.host)
path=$(git config deploy.path)

if [[ -n "$host" ]] && [[ -n "$path" ]]
then
    . ~/loadrc/bashrc/find_up_goto.sh files.proj
    . ~/loadrc/bashrc/rsync.sh . "$host:$path"
fi
