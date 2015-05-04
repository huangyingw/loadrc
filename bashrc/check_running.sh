#! /bin/bash

RSYNCSOURCE=rsync://mirrors.sohu.com/ubuntu/
#RSYNCSOURCE=rsync://debian.nctu.edu.tw/ubuntu/
#RSYNCSOURCE=rsync://ubuntu.dormforce.net/ubuntu/
#RSYNCSOURCE=rsync://mirror.anl.gov/ubuntu/

BASEDIR=/media/volgrp/mirror/

# check to see if script is already running
PDIR=${0%`basename $0`}
LCK_FILE=`basename $0`.lck

if [ -f "${LCK_FILE}" ]; then
  MYPID=`head -n 1 "${LCK_FILE}"`
        
  TEST_RUNNING=`ps -p ${MYPID} | grep ${MYPID}`
          
  if [ -z "${TEST_RUNNING}" ]; then
    # The process is not running
    # Echo current PID into lock file
  echo $$ > "${LCK_FILE}"
  rsync -ahHv --log-file=/root/rlog --delete-after \
      --exclude "*dapper*" --exclude "*hardy*" --exclude "*intrepid*" --exclude "*jaunty*" \
      --exclude "*powerpc*" --exclude "*sparc*" \
    ${RSYNCSOURCE} ${BASEDIR}
  else
      # the process IS running
      # handle it
      exit 0
  fi
else
  echo $$ > "${LCK_FILE}"
fi
