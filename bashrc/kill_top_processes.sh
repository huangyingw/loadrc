#!/bin/zsh
sudo ps -eo pcpu,pid,user,args | grep -v iTerm2 | sort -k 1 -r | head -1 | awk '{print $2}' | while read ss; do sudo kill -9 "$ss"; done
