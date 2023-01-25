#!/bin/zsh

echo git diff \
    --binary \
    --ignore-all-space \
    --ignore-blank-lines \
    --ignore-cr-at-eol \
    --ignore-space-at-eol \
    --ignore-space-change \
    --minimal
