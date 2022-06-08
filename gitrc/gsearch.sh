#!/bin/bash

filesStr=($(< $3))
COMMAND="git log --binary \
    --ignore-all-space \
    --ignore-blank-lines \
    --ignore-cr-at-eol \
    --ignore-space-at-eol \
    --ignore-space-change \
    -p -G $1 -- ${filesStr[@]}"
eval "$COMMAND" > "$2"
