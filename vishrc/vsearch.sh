#!/bin/bash
echo "search in " "$1"
cd "$1"
find_result="$1/""`echo "$2"."$4".findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
if [ -f "$find_result" ]
then
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
cscope_db_file=files.proj
echo "result in " "$find_result"
cscope -dL -f cscope.out -"$3""$2" > "$find_result" 
