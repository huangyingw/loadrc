#!/bin/zsh

host=$(git config deploy.host)
rpath=$(git config deploy.path)

rsync -aHv --force --progress \
    . \
    "$host:$rpath"
