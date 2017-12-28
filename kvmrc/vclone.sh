#!/bin/bash
ORIGIN=$1
TARGET=$2
DIR=/media/volgrp/kvm/"$TARGET"/
if [ ! -d "${DIR}" ]
then
    mkdir -p "${DIR}"
fi
$HOME/loadrc/kvmrc/vdestroy.sh \
    ; virsh undefine --snapshots-metadata "$TARGET" \
    ; virsh destroy "$ORIGIN" \
    ; virsh destroy "$TARGET" \
    ; virt-clone --force --original "$ORIGIN" --name "$TARGET" --file "$DIR"/"$TARGET".qcow2 \
    && virsh start "$TARGET" \
    && virsh dumpxml "$TARGET" > "$DIR"/"$TARGET".xml \
    ; $HOME/loadrc/kvmrc/vresume.sh
