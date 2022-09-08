#!/bin/zsh

if [ -z "$1" ]
then
    target=.
else
    target="$1"
fi

find "$target" -type f -size +100M -exec du -h {} + | sort -r -h | cut -f 2 | while read ss
do
    echo "now checking --> $ss"
    if (ffprobe  -print_format json -show_format -show_streams "$ss" 2>&1 | grep -q 'moov atom not found')
    then
        ~/loadrc/bashrc/append_rate.sh $ss 66
    fi
done
