#!/bin/zsh

rsyncFiles="$(~/loadrc/bashrc/random_string.sh 20)"
cat files.proj | sed 's/^"//g;s/"$//g;s/\\ / /g' > "$rsyncFiles"
PRUNE_POSTFIX=prunefix.rsync
INCLUDE_FILE=includefile.rsync

touch "$PRUNE_POSTFIX"

or="";

[ -f "$PRUNE_POSTFIX" ] && while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    prune_params+=( $or "-wholename" "$suf" )
    or="-o"
done < "$PRUNE_POSTFIX"

or="";

[ -f "$INCLUDE_FILE" ] && while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    include_params+=( $or "-wholename" "$suf" )
    or="-o"
done < "$INCLUDE_FILE"

if [ ${#prune_params[@]} -gt 0 ] ; \
then \
    find . "(" "${prune_params[@]}" ")" -type f -size -9000k > "$rsyncFiles.diff" && \
    comm -23 <(sort "$rsyncFiles") <(sort "$rsyncFiles".diff) > "$rsyncFiles.tmp" && \
    cp -fv "$rsyncFiles.tmp" "$rsyncFiles" ; \
    fi && \
    if [ ${#include_params[@]} -gt 0 ] ; \
    then \
        find . "(" "${include_params[@]}" ")" -type f | sed 's/\(["'\''\]\)/\\\1/g' >> "$rsyncFiles" && \
        sort -u "$rsyncFiles" -o "$rsyncFiles" ; \
        fi && \
        cp -fv "$rsyncFiles" rsync.files && \ 
        rm "$rsyncFiles" "$rsyncFiles.diff" "$rsyncFiles.tmp" "$rsyncFiles.bak" 
