#!/bin/sh
file=${1}
loginFile=.login
if [ -n "$2" ];
then
  loginFile=${2}/.login
fi
user=`cat ${loginFile} |awk -F'=' '/user/{print $2}'`
password=`cat ${loginFile} |awk -F'=' '/password/{print $2}'`
host=`cat ${loginFile} |awk -F'=' '/host/{print $2}'`
dbinstance=`cat ${loginFile} |awk -F'=' '/dbinstance/{print $2}'`
mysql -u"$user" -p"$password" -h${host} ${dbinstance} < ${file}
