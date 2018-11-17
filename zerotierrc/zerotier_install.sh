#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(uname) == "Darwin" ]
then
    exit 0
fi

curl -s https://install.zerotier.com/ | bash
zerotier-cli join 93afae5963560e41

deploy_configs() {
    TARGET="$1"
    SOURCE=~/loadrc/"`hostname`$TARGET"

    if [ -f "$SOURCE" ]
    then
        sudo cp -fv "$SOURCE" "$TARGET"
    fi
}

while read -r line || [[ -n "$line" ]]
do
    deploy_configs "$line"
done < zerotierrc.conf
