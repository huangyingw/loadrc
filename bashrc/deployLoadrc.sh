#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

realDeploy () {
    server="$1"
    echo "Begin loadrc deploy on $server"
    ./rsync.sh ~/loadrc/ "$server":~/loadrc/
    ssh -n "$server" "apt-get install -y vim-gnome cscope"
    ssh -n "$server" "ln -s ~/loadrc/vimrc/.vimrc ~/.vimrc"
    ssh -n "$server" "ln -s ~/loadrc/vimrc/.vim ~/.vim"
    ssh -n "$server" "mkdir -p /export/home1/username/cscope_db/"
}

if [ -n "$1" ]
then
    realDeploy "$1"
    return
fi

while read -r line || [[ -n "$line" ]]; do
    realDeploy "$line"
done < deployLoadrc.list
