#!/bin/zsh
perl -pe 's/\e\[[0-9;]*m(?:\e\[K)?//g' "$1" > "$1".tmp
sed -i.bak "s/\r//g" "$1".tmp
cp -fv "$1".tmp "$1"
