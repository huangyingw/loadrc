#!/bin/zsh
XMLFILE=$1
DOMAIN=$(python ~/loadrc/kvmrc/vsd.py $XMLFILE)
virsh destroy "$DOMAIN" \
    ; virsh define "$XMLFILE" \
    ; virsh start "$DOMAIN"
