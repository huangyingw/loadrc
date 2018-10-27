#!/bin/bash -

find . -type f -name *.ffmpeg.config | while read ss
do
    input=$(echo "$ss" | sed 's/\.ffmpeg.config//g')

    while read line
    do
        output=$(echo "$line" | awk -F',' '{print $1}')
        start=$(echo "$line" | awk -F',' '{print $2}')
        end=$(echo "$line" | awk -F',' '{print $3}')
        ffmpeg -n -ss "$start" -to "$end" -i "$input" "$output"
done < "$ss"
done



#Create a file mylist.txt with all the files you want to have concatenated in the following form (lines starting with a # are ignored):
#
## this is a comment
#file '/path/to/file1'
#file '/path/to/file2'
#file '/path/to/file3'
#Note that these can be either relative or absolute paths. Then you can stream copy or re-encode your files:
#
#ffmpeg -f concat -safe 0 -i mylist.txt -c copy output
