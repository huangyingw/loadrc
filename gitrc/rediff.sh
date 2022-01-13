#!/bin/zsh

DIFF_FILE="$1"
rediff "$DIFF_FILE" | sponge "$DIFF_FILE"
git add "$DIFF_FILE"
