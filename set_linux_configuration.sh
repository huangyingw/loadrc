#!/bin/zsh -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) != "Linux" ]
then
    exit 0
fi

deploy_configs() {
    TARGET="$1"
    SOURCE=~/loadrc/"$TARGET"
    if [ -f "$SOURCE" ]
    then
        ~/loadrc/bashrc/ln_fs.sh "$SOURCE" "$TARGET"
    fi
}

while read -r line || [ -n "$line" ]
do
    deploy_configs "$line"
done < linux.conf
