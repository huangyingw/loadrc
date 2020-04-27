#!/bin/zsh

# https://stackoverflow.com/questions/1616577/surround-all-lines-in-a-text-file-with-quotes-something
input="$1"
output="$2"
ffmpeg -f concat -safe 0 -i "$input" -c copy -y "$output"
