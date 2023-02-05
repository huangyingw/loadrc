#!/bin/zsh
find dogscats/ -type d | while read ss; do find "$ss" -maxdepth 1 -type f | head -n10; done | while read tt; do cp -v "$tt" $(echo "$tt" | sed 's/dogscats/smallset/g'); done
