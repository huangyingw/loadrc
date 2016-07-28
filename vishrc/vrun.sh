#!/bin/bash
file=${1}
if [ $(basename "$file") == "docker-compose.yml" ];
then
  docker-compose up -d
  exit 0
fi
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
esac
