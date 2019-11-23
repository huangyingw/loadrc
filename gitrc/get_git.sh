#!/bin/zsh
DIR=$(dirname "$1")
cd "$DIR"

. ~/loadrc/bashrc/find_up_goto.sh .git
if [ -f .git ]
then
    relative=$(cat .git | awk '{print $2}')
    echo $(realpath "$relative")
else
    echo $(realpath .git)
fi
