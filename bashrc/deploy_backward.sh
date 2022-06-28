#!/bin/zsh

rsync -aHv --force --progress --append-verify \
    --files-from files.rev \
    "$host:/" \
    .
