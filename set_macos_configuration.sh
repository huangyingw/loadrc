#!/bin/zsh 
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Darwin" ]
then
    exit 0
fi

deploy_configs() {
    TARGET="$1"
    SOURCE=~/loadrc/macos/"$TARGET"
    if [ -f "$SOURCE" ]
    then
        sudo cp -fv "$SOURCE" "$TARGET"
    fi
}

while read -r line || [ -n "$line" ]
do
    deploy_configs "$line"
done < macos.conf

./macosrc/configure_mosh.sh
