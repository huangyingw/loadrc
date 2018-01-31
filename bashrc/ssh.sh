#! /bin/bash
target=$(echo "$1" | sed  -e "s/\/$//g")
ssh -Y "$target" -t -- ${tmuxAction}
