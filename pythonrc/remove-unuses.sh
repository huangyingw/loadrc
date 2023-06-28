#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}Please provide TARGET ... ${NC}"
    exit 1
fi

TARGET="$1"
# autoflake --in-place --remove-all-unused-imports "$TARGET"
