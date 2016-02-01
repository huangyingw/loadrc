#!/bin/bash
file=${1}
extension=${file##*.}
case $extension in
  sql)
    ~/loadrc/sqlrc/xsql.sh ${1} ${2} 2>&1 | tee -a ${1}.findresult 
    read -p "press any key to continue...." update
    ;;
  findresult)
    sh ${1} 2>&1 | tee -a ${1}.findresult
    read -p "press any key to continue...." update
    ;;
  sh)
    sh ${1} 2>&1 | tee -a ${1}.findresult 
    read -p "press any key to continue...." update
    ;;
  py)
    python ${1} 2>&1 | tee -a ${1}.findresult 
    read -p "press any key to continue...." update
    ;;
  vim)
    source ${1}
    read -p "press any key to continue...." update
    ;;
esac
