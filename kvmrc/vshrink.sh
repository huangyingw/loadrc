#!/bin/bash -
TARGET=$(realpath "$1")
BAK="$TARGET".bak

mv -v "$TARGET" "$BAK" \
    && qemu-img convert -O qcow2 -c "$BAK" "$TARGET" \
    && rm "$BAK"
