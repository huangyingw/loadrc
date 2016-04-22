#!/bin/bash
if [ -z "$1" ];
then
  TARGETEDIR=`realpath "$PWD"`
else
  TARGETEDIR=`realpath "$1"`
fi
cd "$TARGETEDIR"
cp -nv ~/loadrc/prunefi* ./
cp -nv ~/loadrc/includefile.conf ./
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
INCLUDE_FILE=includefile.conf
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
or="";
while read suf
do
  include_params+=( $or "-wholename" "$suf" )
  or="-o"
done < "$INCLUDE_FILE"
find "$TARGETEDIR" "(" "${prune_params[@]}" "${prune_files[@]}" ")" -a -prune -o -type f -size -9000k -print | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > ${TARGET}
find "$TARGETEDIR" "(" "${include_params[@]}" ")" -type f -size -9000k -print | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' >> ${TARGET}
sort -u ${TARGET} -o ${TARGET}
cscope $PARA -i ${TARGET} 
find /export/home1/username/cscope_db "(" "${prune_params[@]}" "${prune_files[@]}" ")" -a -prune -o -type f -size -9000k -print | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > ~/cscope.findresult
