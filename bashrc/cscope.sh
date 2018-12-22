#!/bin/bash

if [ -z "$1" ]
then
    TARGETEDIR=`realpath "$PWD"`
else
    TARGETEDIR=`realpath "$1"`
fi

cd "$TARGETEDIR"

if [ ! -f files.proj ]
then
    echo -e "${red}No files.proj file here, will not build the index ... ${NC}"
    exit 1
fi

TARGETEDIR=`realpath "$PWD"`
cp -nv ~/loadrc/prunefi* ./
cp -nv ~/loadrc/includefile.conf ./
TARGET=files.proj.bak
PRUNE_POSTFIX=prunefix.conf
PRUNE_FILE=prunefile.conf
INCLUDE_FILE=includefile.conf
or="";

while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    prune_params+=( $or "-iname" "*.$suf" )
    or="-o"
done < "$PRUNE_POSTFIX"

while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    prune_files+=( $or "-wholename" "$suf" )
    or="-o"
done < "$PRUNE_FILE"

or="";

while read suf
do
    suf=$(echo "$suf" | sed 's/"//g')
    include_params+=( $or "-wholename" "$suf" )
    or="-o"
done < "$INCLUDE_FILE"

find . "(" "${prune_params[@]}" "${prune_files[@]}" ")" -a -prune -o -type f -print -exec file {} \; | grep text | cut -d: -f1 | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > ${TARGET} && \
    if [ ${#include_params[@]} -gt 0 ] ; \
    then \
        find . "(" "${include_params[@]}" ")" -type f -size -9000k -print | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' >> ${TARGET} ; \
    fi && \
    sort -u ${TARGET} -o ${TARGET} && \
    cscope -bq -i ${TARGET} -f cscope.out.bak && \
    cp -fv cscope.out.bak cscope.out && \
    cp -fv cscope.out.bak.in cscope.out.in && \
    cp -fv cscope.out.bak.po cscope.out.po && \
    cp -fv ${TARGET} files.proj && \
    sed -i.bak 's/ /\\ /g' files.proj && \
    echo > cscope.small.files && \
    echo "$TARGETEDIR"/files.proj | sed 's/\(["'\''\]\)/\\\1/g;s/ /\\ /g;s/.*/"&"/' >> ~/all.proj && \
    sort -u ~/all.proj -o ~/all.proj
