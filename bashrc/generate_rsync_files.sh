#!/bin/zsh

echo  /Users/huangyingw/loadrc/bashrc/generate_rsync_files.sh >> ~/loadrc/debug.runresult
rsyncFiles=rsync.files.tmp
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
    cp -fv "$rsyncFiles.tmp" "$rsyncFiles" && \
    comm -23 <(sort "$rsyncFiles") <(sort files.rev) > "$rsyncFiles.tmp" && \
    cp -fv "$rsyncFiles.tmp" "$rsyncFiles" && \
    fi && \
    if [ ${#include_params[@]} -gt 0 ] ; \
    then \
        find . "(" "${include_params[@]}" ")" -type f | sed 's/\(["'\''\]\)/\\\1/g' >> "$rsyncFiles" && \
        sort -u "$rsyncFiles" -o "$rsyncFiles" ; \
        fi && \
        cp -fv "$rsyncFiles" rsync.files
