#!/bin/bash -
if [ -z "$1" ]
then
    echo -e "${red}Please provide the qcow2 file ... ${NC}"
    exit 1
fi

TARGET=$(realpath "$1")
BAK="$TARGET".bak

mv -v "$TARGET" "$BAK" \
    && qemu-img convert -O qcow2 -c "$BAK" "$TARGET" \
    && rm "$BAK"
