#!/bin/zsh

TARGET=all.list.bak
PRUNE_POSTFIX=all_prunefix.conf

find . "(" "${prune_params[@]}" ")" -a -prune -o -size +0 -type f -exec grep -Il "" {} + > "$TARGET" ; \
