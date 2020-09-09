#!/bin/zsh
rsyncFiles=rsync.files.bak
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

if [ ${#include_params[@]} -gt 0 ] ; \
then \
    find . "(" "${include_params[@]}" ")" -type f -size -9000k | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' >> ${rsyncFiles} ; \
    fi && \
    if [ ${#prune_params[@]} -gt 0 ] ; \
    then \
        find . "(" "${prune_params[@]}" ")" -type f -size -9000k > "$rsyncFiles".diff && \
        comm -23 <(sort "$rsyncFiles") <(sort "$rsyncFiles".diff) > "$rsyncFiles".tmp && \
        cp -fv "$rsyncFiles".tmp rsync.files ; \
    else \
        cp -fv "$rsyncFiles" rsync.files ; \
    fi
