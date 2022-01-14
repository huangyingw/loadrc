#!/bin/zsh

DIFF_FILE="$1"
rediff "$DIFF_FILE" | sponge "$DIFF_FILE"
