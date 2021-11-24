#!/bin/sh
file="$1"
loginFile=.login

if [ -n "$2" ]
then
    loginFile=${2}/.login
fi

echo "loginFile --> $loginFile"
user=`cat ${loginFile} |awk -F'=' '/user/{print $2}'`
password=`cat ${loginFile} |awk -F'=' '/password/{print $2}'`
host=`cat ${loginFile} |awk -F'=' '/host/{print $2}'`
dbinstance=`cat ${loginFile} |awk -F'=' '/dbinstance/{print $2}'`
protocol=`cat ${loginFile} |awk -F'=' '/protocol/{print $2}'`
option=""

if [ -z "$host" ]
then
    echo "dbinstance=$dbinstance" >> "$loginFile"
    echo "host=$host" >> "$loginFile"
    echo "password=$password" >> "$loginFile"
    echo "user=$user" >> "$loginFile"
    sort -u "$loginFile" -o "$loginFile"
fi

if [ -n "$protocol" ]
then
    option="--protocol=$protocol"
fi

cd "$(dirname "$file")"
mysql -v "$option" -u"$user" -p"$password" -h${host} ${dbinstance} < ${file}
