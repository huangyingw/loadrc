#!/bin/zsh
if [ -z "$1" ]
then
    echo "Please provide parameter"
else
    if [ ! -d "temp" ]
    then
        if [ ! -d "$1/.git" ]
        then
            echo git does not exist!!!
        else
            git clone --bare "$1" "temp"
            rm -frv "$1"
            mv -fv "temp" "$1"
            chmod -R 777 "$1"
        fi
    else
        echo the temp exist!!!
    fi
fi
