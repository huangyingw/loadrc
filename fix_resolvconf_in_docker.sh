#!/bin/bash

if [ $(uname) = "Darwin" ]
then
    exit 0
fi

apt-get update
apt-get install -y apt-utils debconf-utils dialog
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections
