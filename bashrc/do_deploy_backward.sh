#!/bin/zsh

rsync -aHv --force --progress \
    --files-from files.rev \
    "$host:/" \
    .
