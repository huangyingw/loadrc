#!/bin/bash
if [ -z "$1" ];
then
	echo "Please provide parameter"
else
	if [ ! -d "temp" ];
	then
		if [ ! -d "$1/.git" ];
		then
			cd "$1"
			git init
			git add .
			git commit -am "n"
			cd ..
	    git clone --bare "$1" "temp"
			rm -frv "$1"
			mv -fv "temp" "$1"
			chmod -R 777 "$1"
		else
	 		echo git exist!!!
		fi
	else
	 	echo the temp exist!!!
	fi
fi
	