#!/bin/zsh
file=${1}
if [ $(basename "$file") = "gbil.log" ]
then
    ~/loadrc/gitrc/gbir.sh
    exit 0
fi

extension=${file##*.}

case $extension in
    sql)
        ~/loadrc/sqlrc/xsql.sh ${1} ${2} 2>&1 | tee ${1}.findresult
        ;;
    findresult)
        sh ${1} 2>&1 | tee ${1}.findresult
        ;;
    sh)
        sh ${1} 2>&1 | tee ${1}.findresult
        ;;
    py)
        python ${1} 2>&1 | tee ${1}.findresult
        ;;
    vim)
        source ${1}
        ;;
    yml)
        docker-compose -f "$file" up --build --force-recreate 2>&1 | tee "$file".findresult
        ;;
    ymldebug)
        docker-compose -f "$file" up --build --force-recreate 2>&1 | tee "$file".findresult
        ;;
esac
