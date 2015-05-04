#!/bin/bash
if [ -z "$1" ];
then
  TARGETEDIR=`realpath "$PWD"`
else
  TARGETEDIR=`realpath "$1"`
fi
cd "$TARGETEDIR"
TARGET='/export/home1/username/cscope_db/'`pwd |sed -e "s/^.*\///g"`
echo $TARGET
PARA=-bqR
PRUNE_POSTFIX=prunefix.findresult
PRUNE_FILE=prunefile.findresult
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
find "$TARGETEDIR" "(" "${prune_params[@]}" "${prune_files[@]}" ")" -a -prune -o -type f -size -9000k -print |sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > ${TARGET}
cscope $PARA -i ${TARGET} 
