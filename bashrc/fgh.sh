#!/bin/zsh
function iterate_dir(){
    for file in "$1"/*
    do
        if [ -d "$file" ]
        then
            if [ -d "$file/.git" ]
            then
                $HOME/loadrc/bashrc/gagh.sh "$file"
            else
                iterate_dir "$file"
            fi
        fi
    done
}
if [ -z "$1" ]
then
    iterate_dir .
else
    iterate_dir "$1"
fi
