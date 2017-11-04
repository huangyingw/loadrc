#!/bin/bash
target=$(echo "$1" | sed  -e "s/\/$//g")
if [ -z "$1" ]
then
    ssh server pm-suspend
fi
ssh "$target" pm-suspend
