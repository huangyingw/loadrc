#!/bin/zsh
perl -pe 's/\e\[[0-9;]*m(?:\e\[K)?//g' "$1" > "$1".bak
cp -fv "$1".bak "$1"
