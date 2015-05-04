#!/bin/bash
PRUNE_POSTFIX="$HOME/bashrc/prunefix"
PRUNE_FILE="$HOME/bashrc/prunefile"
prune_params=();
find_result="`echo "$2".fd.findresult |sed  -e "s/\//\_/g"`"
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
find "$1" "(" "${prune_params[@]}" "${prune_files[@]}" ")" -prune -type d -o -iname "$2" -print > "$find_result"
if [ -f cscope.out ]; then
  ~/loadrc/bashrc/cscope.sh
else
  vi "$find_result"
fi
