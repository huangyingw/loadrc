#!/bin/bash
file=${1}
if [ $(basename "$file") == "gbil.findresult" ];
then
    ~/loadrc/gitrc/gbir.sh
    exit 0
fi
extension=${file##*.}
case $extension in
    sql)
        ~/loadrc/sqlrc/xsql.sh ${1} ${2} 2>&1 | tee ${1}.findresult
        read -p "press any key to continue...." update
        ;;
    findresult)
        sh ${1} 2>&1 | tee ${1}.findresult
        read -p "press any key to continue...." update
        ;;
    sh)
        sh ${1} 2>&1 | tee ${1}.findresult
        read -p "press any key to continue...." update
        ;;
    py)
        python ${1} 2>&1 | tee ${1}.findresult
        read -p "press any key to continue...." update
        ;;
    vim)
        source ${1}
        read -p "press any key to continue...." update
        ;;
    yml)
        docker-compose -f "$file" up -d 2>&1 | tee "$file".findresult
        docker-compose -f "$file" restart 2>&1 | tee "$file".findresult
        read -p "press any key to continue...." update
        ;;
    ymldebug)
        docker-compose -f "$file" up --build --force-recreate 2>&1 | tee "$file".findresult
        read -p "press any key to continue...." update
        ;;
esac
