#!/bin/zsh
touch files.proj \
    && git config --file .gitconfig deploy.host localhost \
    && git config --file .gitconfig deploy.path "~/$(realpath --relative-to=$HOME/ $PWD)"
