#!/bin/bash
find_result="`echo "$2".grep.findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
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
grep "$2" "$1" -rnH \
  --exclude=\*.findresult \
  --exclude=\*.swp \
  --exclude=cscope.out \
  --exclude=cscope.in.out \
  > "$find_result"
vi "$find_result"
