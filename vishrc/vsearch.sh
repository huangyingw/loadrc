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

echo "result in " "$find_result"

if [[ "$3" == "w" ]]
then
    xargs grep -wnH "$2" < files.proj > "$find_result"
else
    cscope -dL -f cscope.out -"$3""$2" > "$find_result"
fi
