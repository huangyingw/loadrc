#!/bin/zsh
#===============================================================================
#
#          FILE: binaryGrep.sh
#
#         USAGE: ./binaryGrep.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 05/03/2016 16:12
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

find_result="`echo "$1".binaryGrep.findresult |sed  -e "s/\//\_/g;s/\ /\_/g"`"
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
grep -rl \
    --include *.jar \
    --include *.class \
    --include *.tar \
    --include *.war \
    --include *target* \
    "$1" \
    . > "$find_result"
grep -rl \
    --include *.jar \
    --include *.class \
    --include *.tar \
    --include *.war \
    "$1" \
    ~/.m2/ >> "$find_result"
