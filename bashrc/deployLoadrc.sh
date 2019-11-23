#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

realDeploy () {
    server="$1"
    echo "Begin loadrc deploy on $server"
    ./rsync.sh "$server":~/loadrc/
    ssh -n "$server" "sudo apt-get update && sudo apt-get install -y vim-gnome cscope git tmux mosh htop realpath"
    ssh -n "$server" "ln -fs ~/loadrc/vimrc/.vimrc ~/.vimrc"
    ssh -n "$server" "ln -fs ~/loadrc/vimrc/.vim ~/.vim"
    ssh -n "$server" "ln -fs ~/loadrc/gitrc/.gitconfig ~/.gitconfig"
    ssh -n "$server" "ln -fs ~/loadrc/gitrc/.globalgitignore ~/.globalgitignore"
}

if [ -n "$1" ]
then
    realDeploy "$1"
    exit
fi

while read -r line || [[ -n "$line" ]]
do
    realDeploy "$line"
done < deployLoadrc.list
