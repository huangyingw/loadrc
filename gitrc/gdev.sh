#!/bin/zsh
touch files.proj \
    && git config --file .gitconfig deploy.host localhost \
    && git config --file .gitconfig deploy.path "~/${PWD#$HOME/}"
