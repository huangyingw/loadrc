#!/bin/zsh
if [ -f "run.sh" ]
then
    ./run.sh
else
    if [ -f "run" ]
    then
        ./run
    fi
fi
