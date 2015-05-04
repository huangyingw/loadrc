#!/bin/bash

if [ -z "$1" ];
then
	echo "Please provide parameter"
else
	x=`echo $1 | sed -e "s|/media/smb|$HOME|"`
	echo ${x}
fi


if [ -d ${x} ];
then
	echo local repository exist!!!
else
	#echo "git clone -v "$1" ${x}"
	git clone -v "$1" ${x}
fi
