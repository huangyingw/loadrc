#!/bin/bash
FILE_POSTFIX=$HOME/bashrc/postfix
PRUNE_POSTFIX=$HOME/bashrc/prunefix
PRUNE_FILE=$HOME/bashrc/prunefile
find_params=();
prune_params=();
prune_files=();
find_result="`echo "$2".fww.findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
if [ -f "$find_result" ]; then
  read -p "the search is already done, if you want to update, press u --> " update
  case $update in
    u)
      ;;
    ?)
      vi "$find_result"
      exit 1
      ;;
  esac
fi
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
find -L "$1" "(" "${prune_params[@]}" "${prune_files[@]}" "-o" "-name" "$find_result" ")" -prune -o "(" "${find_params[@]}" "-o" "-iname" "makefile" ")" -type f -exec fgrep -wnH  $grep_params "$2" {} \; > "$find_result"
if [ -f cscope.out ]; then
  ~/loadrc/bashrc/cscope.sh
else
  vi "$find_result"
fi
