#!/bin/zsh

host=$(git config deploy.host)
rpath=$(git config deploy.path)

rsync -aHv --force --progress --append-verify \
    --files-from files.rev \
    "$host:/" \
    .
