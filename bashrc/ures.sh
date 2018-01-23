#!/bin/bash
OS=`uname`
if [ $(uname) == "Darwin" ]
then
    echo -e "${red}It could only run in Linux... ${NC}"
    exit 1
fi
SOURCE=/media/volgrp/slink/media/`hostname`/
TARGET=/
if [ -n "$1" ]
then
    SOURCE="$1"
fi
if [ -n "$2" ]
then
    TARGET="$2"
fi
echo $SOURCE
echo $TARGET
URESEX="$HOME/loadrc/bashrc/ures_ex"
URESIN="$HOME/loadrc/bashrc/ures_in"
exclude_params=();
while read suf
do
    exclude_params+=( "--exclude=$suf" )
done < "$URESEX"
include_params=();
while read suf
do
    include_params+=( "--include=$suf" )
done < "$URESIN"
rsync -aH --force --delete-during "${exclude_params[@]}" "${SOURCE}" "${TARGET}"
