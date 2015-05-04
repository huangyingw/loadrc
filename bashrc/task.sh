#! /bin/bash
check_bool=`~/myproject/git/linux/bashrc/check_disk.sh`


if [ ${check_bool} -eq 1 ];   
then
	/home/yinghuang/myproject/git/linux/bashrc/rsync.sh /media/volgrp/myproject/ /media/160g/work_myproject/
	/home/yinghuang/myproject/git/linux/bashrc/rsync.sh /media/160g/home_myproject/ /media/volgrp/home_myproject/
	if [ "$1" != s ];
		then
			shutdown -h now
	fi
else
 	echo the disks not ready!!!
fi
