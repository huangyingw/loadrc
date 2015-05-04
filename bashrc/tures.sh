#!/bin/bash 
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
URESEX="$HOME/bashrc/ures_ex"
URESIN="$HOME/bashrc/ures_in"
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
rsync -aHinv --force --delete-during "${exclude_params[@]}" "${SOURCE}" "${TARGET}"> find.cc
vi find.cc
