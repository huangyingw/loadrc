#! /bin/bash
target=$(echo "$1" | sed  -e "s/\/$//g")
ssh -X "$target" -t -- ${tmuxAction}
