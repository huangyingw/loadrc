#!/bin/zsh

host=$(git config deploy.host)
rpath=$(git config deploy.path)

if [ "$host" = "localhost" ]
then
    exit 0
fi

if [[ -n "$host" ]] && [[ -n "$rpath" ]]
then
    ssh -n "$host" "mkdir -p $rpath"
    ~/loadrc/bashrc/deploy_forward.sh &
    ~/loadrc/bashrc/deploy_backward.sh &
fi
