#!/bin/bash -
host=$(git config deploy.host)
path=$(git config deploy.path)

cat files.proj | sed 's/^"//g;s/"$//g;s/\\ / /g' > files.proj.tmp && \
    rsync -aHv --force --progress \
    --files-from files.proj.tmp \
    . \
    "$host:$path"
