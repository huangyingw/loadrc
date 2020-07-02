#!/bin/zsh
rsyncFiles=rsync.files.bak
cat files.proj | sed 's/^"//g;s/"$//g;s/\\ / /g' > "$rsyncFiles"
PRUNE_POSTFIX=prunefix.rsync

if [ ! -f "$PRUNE_POSTFIX" ]
then
    exit
fi

or="";

while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    include_params+=( $or "-wholename" "$suf" )
    or="-o"
done < "$PRUNE_POSTFIX"

find . "(" "${include_params[@]}" ")" -type f -size -9000k > "$rsyncFiles".tmp && \
    comm -23 <(sort "$rsyncFiles") <(sort "$rsyncFiles".tmp) > "$rsyncFiles" && \
    cp -fv "$rsyncFiles" rsync.files
