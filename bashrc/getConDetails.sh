#!/bin/bash - 
SOURCE="$1" 
echo $SOURCE

DOMAIN=${SOURCE%:*}  # get the part before the colon
user=${DOMAIN%@*}  
host=${DOMAIN##*@}
if [ $user == $host ];
then
  user="root"
fi
folder=${SOURCE##*:}
