#! /bin/bash
TARGET=/media/volgrp/slink/media/`hostname`/
if [ -n "$1" ]
then 
    TARGET="$1":$TARGET
fi
echo $TARGET
UBAKEX="$HOME/bashrc/ubak_ex"
UBAKIN="$HOME/bashrc/ubak_in"
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
rsync -aH --force --delete-during "${exclude_params[@]}" "${include_params[@]}" / "${TARGET}" \
    && $HOME/bashrc/sleep.sh
