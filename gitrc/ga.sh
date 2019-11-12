#!/bin/zsh
while read -r line || [[ -n "$line" ]]
do
    git add -f $(echo "$line" | sed 's/^"//g;s/"$//g;s/\\ / /g')
done < files.proj
