#!/bin/bash -
touch files.proj \
    && git config --file .gitconfig commit.message n \
    && git config --file .gitconfig merge.allow true \
    && git config --file .gitconfig vrun.silent false \
    && git config --file .gitconfig vrun.async false
