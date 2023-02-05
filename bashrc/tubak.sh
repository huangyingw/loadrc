#! /bin/zsh
TARGET=/media/volgrp/media/`hostname`/
if [ -n "$1" ]
then
  TARGET="$1"
fi
echo $TARGET
UBAKEX="$HOME/loadrc/bashrc/ubak_ex"
UBAKIN="$HOME/loadrc/bashrc/ubak_in"
exclude_params=();
while read suf
do
  exclude_params+=( "--exclude=$suf" )
done < "$UBAKEX"
include_params=();
while read suf
do
  include_params+=( "--include=$suf" )
done < "$UBAKIN"
rsync -aHinv --force --delete-during "${exclude_params[@]}" "${include_params[@]}" / "${TARGET}" > find.findresult
nvim find.findresult
