#!/bin/zsh

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
cp -nv ~/loadrc/prunefix_template.conf ./prunefix.conf
cp -nv ~/loadrc/prunefile_template.conf ./prunefile.conf
cp -nv ~/loadrc/includefile_template.conf ./includefile.conf
cp -nv ~/loadrc/setup.cfg ./setup.cfg
TARGET=files.proj.bak
PRUNE_POSTFIX=prunefix.conf
PRUNE_FILE=prunefile.conf
INCLUDE_FILE=includefile.conf

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

export LC_ALL=C
find . "(" "${prune_params[@]}" ")" -a -prune -o -size +0 -type f -exec grep -Il "" {} + | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > "$TARGET" && \
    comm -23 <(sort "$TARGET") <(sort "$PRUNE_FILE") > "$TARGET.tmp" && \
    cp -fv "$TARGET.tmp" "$TARGET" && \
    if [ ${#include_params[@]} -gt 0 ] ; \
    then \
        find . "(" "${include_params[@]}" ")" -type f -size -9000k | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' >> ${TARGET} ; \
        fi && \
        sort -u "$TARGET" -o "$TARGET" && \
        cp -fv "$TARGET" files.proj && \
        sed -i.bak 's/ /\\ /g' files.proj && \
        echo "$TARGETEDIR"/files.proj | sed 's/\(["'\''\]\)/\\\1/g;s/ /\\ /g;s/.*/"&"/' >> ~/all.proj && \
        sort -u ~/all.proj -o ~/all.proj
