#! /bin/bash
OS=`uname`
if [ "$OS" != "Darwin" ]
then
  echo -e "${red}It could only run in OS X... ${NC}"
  exit 1
fi
TARGET=root@mini:/media/volgrp/media/`hostname`/
MBAKEX="$HOME/loadrc/bashrc/mbak_ex"
MBAKIN="$HOME/loadrc/bashrc/mbak_in"
exclude_params=();
while read suf
do
  exclude_params+=( "--exclude=$suf" )
done < "$MBAKEX"
include_params=();
while read suf
do
  include_params+=( "--include=$suf" )
done < "$MBAKIN"
sudo rsync -aHv --progress --force --delete-during "${exclude_params[@]}" "${include_params[@]}" / "${TARGET}"
