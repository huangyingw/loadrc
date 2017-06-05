#!/bin/bash
echo "keyword --> $2"
find_result="$3".vaa.findresult
echo "find_result --> $find_result"
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
xargs fgrep -inH "$2" < "$cscope_db_file" > "$find_result"
