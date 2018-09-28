#! /bin/bash
if [ -z "$1" ]
then
    FAV=~/var/lib/mldonkey/incoming/files/
else
    FAV=`realpath "$1"`
fi

cd "$FAV"

find . -type f -size +100M -exec ls -t {} \+ > fav.log
touch files.proj
. ~/loadrc/bashrc/cscope.sh
