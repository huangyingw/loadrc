#!/bin/zsh
host=$(git config deploy.host)
rpath=$(git config deploy.path)

rsync -aHv --force --progress \
    --files-from files.proj.tmp \
    . \
    "$host:$rpath"
