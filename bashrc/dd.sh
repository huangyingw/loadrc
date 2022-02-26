#!/bin/zsh

input="$1"
output="$2"
(pv -n "$input" | dd of="$output" bs=128M conv=notrunc,noerror) 2>&1 | dialog --gauge "Running dd command (cloning), please wait..." 10 70 0
