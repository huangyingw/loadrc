#!/bin/zsh
input="$1"
output=$(echo "$input" | sed 's/\.py$/\.ipynb/g')

ipynb-py-convert "$input" "$output"
