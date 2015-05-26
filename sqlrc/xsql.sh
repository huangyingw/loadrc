#!/bin/sh
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ ! $(git ls-files|grep '.login') ] || [ git status|grep -q '.login' ];
then
  echo -e "${red}the .login is unclean, please check it before continuing... ${NC}"
  exit 1
fi
file=${1}
user=`cat .login |awk -F'=' '/user/{print $2}'`
password=`cat .login |awk -F'=' '/password/{print $2}'`
host=`cat .login |awk -F'=' '/host/{print $2}'`
dbinstance=`cat .login |awk -F'=' '/dbinstance/{print $2}'`
mysql -u"$user" -p"$password" -h${host} ${dbinstance} < ${file}
