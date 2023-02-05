#!/bin/zsh

find . -type f -name \*.ffmpeg.config | while read ss
do
    input=$(echo "$ss" | sed 's/\.ffmpeg.config//g')

    while read line
    do
        output=$(echo "$line" | awk -F',' '{print $1}')
        start=$(echo "$line" | awk -F',' '{print $2}')
        end=$(echo "$line" | awk -F',' '{print $3}')
        if [ ! -f "$output" ]
        then
            ffmpeg -n -ss "$start" -to "$end" -i "$input" "$output"
        fi
    done < "$ss"
done
