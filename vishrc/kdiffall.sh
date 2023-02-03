#!/bin/zsh
IFS=$'\n' lines=($(cat $1))

for index in {1..$#lines}
do
    for ((next = $index + 1; next <= $#lines; next++));
    do
        one=$(echo "${lines[$index]}" | sed 's/"//g')
        two=$(echo "${lines[$next]}" | sed 's/"//g')
        kdiff3 "$one" "$two"
    done
done
