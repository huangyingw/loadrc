#!/bin/bash
PRUNE_POSTFIX="$1/"prunefix.findresult
PRUNE_FILE="$1/"prunefile.findresult
prune_params=();
prune_files=();
find_result="$1/""`echo "$2".faa.findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
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
or="";
grep_params="";
if [ -n "$3" ]
then grep_params=" -A"$3" -B"$3;
fi
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
echo "search in " "$1"
cd "$1"
echo "result in " "$find_result"
find "$1" "(" "${prune_params[@]}" "${prune_files[@]}" "-o" "-name" "$find_result" ")" -prune -o -type f -exec fgrep -wnH  $grep_params "$2" {} \; > "$find_result"
vi "$find_result"
