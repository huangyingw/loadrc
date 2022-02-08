#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) = "Darwin" ]
then
    ./bashrc/update_proj.sh
fi

./gitrc/gclean.sh
chown $(whoami) -R ~/loadrc/oh-my-zsh/
chown $(whoami) ~/.ssh/config
