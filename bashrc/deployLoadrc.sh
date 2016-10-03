#!/bin/bash - 
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

while read -r line || [[ -n "$line" ]]; do
    echo "Begin loadrc deploy on $line"
    ./rsync.sh ~/loadrc/ "$line":~/loadrc/
    ssh -n "$line" "apt-get install -y vim-gnome cscope"
    ssh -n "$line" "ln -s ~/loadrc/vimrc/.vimrc ~/.vimrc"
    ssh -n "$line" "ln -s ~/loadrc/vimrc/.vim ~/.vim"
done < deployLoadrc.list
