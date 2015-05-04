#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
FILE_POSTFIX=postfix.findresult
PRUNE_POSTFIX=prunefix.findresult
PRUNE_FILE=prunefile.findresult
find_params=();
prune_params=();
prune_files=();
or="";
grep_params="";
if [ -n "$3" ]
then grep_params=" -A"$3" -B"$3;
fi
while read suf
do
  find_params+=( $or "-iname" "*.$suf" )
  or="-o"
done < "$FILE_POSTFIX"
or="";
while read suf
do
  prune_params+=( $or "-iname" "*.$suf" )
  or="-o"
done < "$PRUNE_POSTFIX"
while read suf
do
  prune_files+=( $or "-iname" "$suf" )
  or="-o"
done < "$PRUNE_FILE"
FIND=$2
REPLACE=$3
if [ -n "$1" ];
then
  folderForGit="$1"
else
  folderForGit=.
fi
OS=`uname`
if [ "$OS" == "Linux" ]
then
  find "$1" "(" "${prune_params[@]}" "${prune_files[@]}" ")" -prune -o "(" "${find_params[@]}" "-o" "-iname" "makefile" ")" -type f -exec sed -i""  "s|${FIND}|${REPLACE}|g" {} +
else
  find "$1" "(" "${prune_params[@]}" "${prune_files[@]}" ")" -prune -o "(" "${find_params[@]}" "-o" "-iname" "makefile" ")" -type f -exec sed -i ""  "s|${FIND}|${REPLACE}|g" {} +
fi
