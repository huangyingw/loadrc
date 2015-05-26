#!/bin/sh
file=${1}
user=`cat .login |awk -F'=' '/user/{print $2}'`
password=`cat .login |awk -F'=' '/password/{print $2}'`
host=`cat .login |awk -F'=' '/host/{print $2}'`
dbinstance=`cat .login |awk -F'=' '/dbinstance/{print $2}'`
mysqldump -u"$user" -p"$password" -h${host} ${dbinstance} > ${file}
