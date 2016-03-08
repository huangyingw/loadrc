#!/bin/bash
if [ -z "$1" ];
then
  TARGETEDIR=`realpath "$PWD"`
else
  TARGETEDIR=`realpath "$1"`
fi
cd "$TARGETEDIR"
cp -nv ~/loadrc/prunefi* ./
TARGET=`pwd |sed -e "s/^.*\///g"`
if [ -z $TARGET ];
then
  TARGET='osroot'
fi
TARGET='/export/home1/username/cscope_db/'$TARGET
echo $TARGET
PARA=-bqR
PRUNE_POSTFIX=prunefix.conf
PRUNE_FILE=prunefile.conf
or="";
while read suf
do
  prune_params+=( $or "-iname" "*.$suf" )
  or="-o"
done < "$PRUNE_POSTFIX"
while read suf
do
  prune_files+=( $or "-wholename" "$suf" )
  or="-o"
done < "$PRUNE_FILE"
find "$TARGETEDIR" "(" "${prune_params[@]}" "${prune_files[@]}" ")" -a -prune -o -type f -size -9000k -print -exec file {} \; | grep text | cut -d: -f1 | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' | sort -u > ${TARGET}
cscope $PARA -i ${TARGET} 
find /export/home1/username/cscope_db "(" "${prune_params[@]}" "${prune_files[@]}" ")" -a -prune -o -type f -size -9000k -print | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > ~/cscope.findresult
