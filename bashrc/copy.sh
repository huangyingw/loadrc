#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

source=$1
target=$2

if [[ "$target" != *":"* ]] && [[ ! -d "$target" ]]
then
    mkdir -p "$target"
fi

siconv=$(~/loadrc/bashrc/get_iconv.sh "$source")
ticonv=$(~/loadrc/bashrc/get_iconv.sh "$target")

rsync -aHSv --progress --force \
    --iconv="$ticonv,$siconv" \
    "$source" "$target"
