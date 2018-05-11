#!/bin/bash
file=${1}
if [ $(basename "$file") == "gbil.findresult" ]
then
    ~/loadrc/gitrc/gbir.sh
    exit 0
fi
extension=${file##*.}
case $extension in
    sql)
        ~/loadrc/sqlrc/xsql.sh ${1} ${2}
        ;;
    findresult)
        sh ${1}
        ;;
    sh)
        bash ${1}
        ;;
    py)
        SCRIPT=$(realpath "$1")
        SCRIPTPATH=$(dirname "$SCRIPT")
        cd "$SCRIPTPATH"
        python ${1}
        ;;
    vim)
        source ${1}
        ;;
    yml)
        docker-compose -f "$file" up -d
        ;;
    ymldebug)
        docker-compose -f "$file" up --build --force-recreate
        ;;
esac

if [[ "$file" = *'.leetcode.'* ]]
then
    leetcode submit "$file"
fi
