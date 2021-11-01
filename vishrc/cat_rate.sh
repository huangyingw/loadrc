#!/bin/zsh

result=()

while read ss
do
    ~/loadrc/bashrc/append_rate.sh "$ss" "$2"
    target=$(~/loadrc/bashrc/append_num.sh "$ss" "$2")
    result+=("$target")
done < "$1"

printf "%s\n" "${result[@]}" > "$1".tmp
cp -fv "$1".tmp "$1"
