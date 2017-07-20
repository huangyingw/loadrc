#!/bin/bash
if [ -z "$1" ];
then
    echo "Please provide tag name"
    exit 1
fi
if [ -z "$2" ];
then
    echo "Please provide commit message"
    exit 1
fi
git tag "$1" -m "$2"
~/loadrc/gitrc/gps.sh
