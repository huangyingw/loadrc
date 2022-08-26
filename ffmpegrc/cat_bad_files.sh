#!/bin/zsh

while read ss
do
    if ! (~/loadrc/ffmpegrc/check_moov_atom.sh "$ss")
    then
        ~/loadrc/bashrc/append_rate.sh $ss 66
    fi
done < "$1"
