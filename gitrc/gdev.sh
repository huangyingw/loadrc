#!/bin/zsh -
touch files.proj \
    && git config --file .gitconfig commit.message n \
    && git config --file .gitconfig merge.allow true \
    && git config --file .gitconfig vrun.silent false \
    && git config --file .gitconfig vrun.async false \
    && git config --file .gitconfig deploy.host localhost \
    && git config --file .gitconfig deploy.path "~/myproject/$(realpath --relative-to=$HOME/myproject $PWD)"
