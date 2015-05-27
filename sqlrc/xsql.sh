#!/bin/sh
file=${1}
user=`cat ${2}/.login |awk -F'=' '/user/{print $2}'`
password=`cat ${2}/.login |awk -F'=' '/password/{print $2}'`
host=`cat ${2}/.login |awk -F'=' '/host/{print $2}'`
dbinstance=`cat ${2}/.login |awk -F'=' '/dbinstance/{print $2}'`
mysql -u"$user" -p"$password" -h${host} ${dbinstance} < ${file}
