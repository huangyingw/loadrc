#!/bin/bash
find_result="$1/""`echo "$2"."$4".findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
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
echo "search in " "$1"
cd "$1"
cscope_db_file=cscope.findresult
echo "result in " "$1/$find_result"
xargs fgrep -wnH "$2" < "$cscope_db_file" > "$find_result"
