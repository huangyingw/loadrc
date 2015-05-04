#!/bin/bash
if [ -z "$1" ];
then
  TARGETEDIR=`realpath "$PWD"`
else
  TARGETEDIR=`realpath "$1"`
fi
cd "$TARGETEDIR"
find_result="$1/""`echo "$2".fa.findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
if [ -f "$find_result" ]; then
  read -p "the search is already done, if you want to update, press u --> " update
  case $update in
    u)
      ;;
    "")
      exit 1
      ;;
    ?)
      exit 1
      ;;
  esac
fi
grep_params="";
if [ -n "$3" ]
then grep_params=" -A"$3" -B"$3;
fi
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
find "$TARGETEDIR" "(" "${prune_params[@]}" "${prune_files[@]}" ")" -a -prune -o -type f -size -9000k -exec fgrep -inH  $grep_params "$2" {} \; > "$find_result"
vi "$find_result"
