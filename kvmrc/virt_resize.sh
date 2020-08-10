#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

# https://maunium.net/blog/resizing-qcow2-images/
target="$1"
size="$2"
qemu-img create -f qcow2 -o preallocation=metadata "$target".tmp "$size" && \
    virt-resize "$target" "$target".tmp && \
    mv -v "$target" "$target".bak && \
    mv -v "$target".tmp "$target"
