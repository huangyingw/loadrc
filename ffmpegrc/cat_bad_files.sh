#!/bin/zsh

while read ss
do
    if ! (~/loadrc/ffmpegrc/check_moov_atom.sh "$ss")
    then
        echo "~/loadrc/bashrc/append_rate.sh $ss 6"
    fi
done < "$1"
