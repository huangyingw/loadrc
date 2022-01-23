#!/bin/zsh

rsync_basic_option=(
    -aHSv \
        --progress \
        --force \
        --append-verify
    )
