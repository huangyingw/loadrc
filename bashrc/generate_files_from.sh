#!/bin/zsh
cat files.proj | sed 's/^"//g;s/"$//g;s/\\ / /g' > rsync.files
PRUNE_POSTFIX=prunefix.rsync

if [ ! -f "$PRUNE_POSTFIX" ]
then
    exit
fi

or="";

while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    prune_params+=( $or "-wholename" "$suf" )
    or="-o"
done < "$PRUNE_POSTFIX"
find . "(" "${prune_params[@]}" ")" -a -prune -o -size +0 -type f -exec grep -Il "" {} +
