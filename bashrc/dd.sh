#!/bin/zsh

input="$1"
output="$2"

if [[ "$input" = *'.img' ]] && [[ "$output" = *'/dev/'* ]]
then
    (pv -n "$input" | dd of="$output" bs=128M conv=notrunc,noerror) 2>&1 | gunzip -c | dialog --gauge "Running dd command (cloning), please wait..." 10 70 0
elif [[ "$output" = *'.img' ]] && [[ "$input" = *'/dev/'* ]]
then
    (pv -n "$input" | gzip -c1 | dd of="$output" bs=128M conv=notrunc,noerror) 2>&1 | dialog --gauge "Running dd command (cloning), please wait..." 10 70 0
fi
