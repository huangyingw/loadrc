#! /bin/bash

mainsource="/pcc/cnbuild/build/output/"
localmain="/media/volgrp/work/platform/pcc/cnbuild/build/output/"

FILE_TYPE="$HOME/bashrc/file_type"
command_params=`cat ${FILE_TYPE}|{ read suf; echo -n "--include=$suf/**";while read suf;do echo -n " --include=$suf";done;     }`


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
    rsync -avH --include=*/  $command_params --exclude=* --prune-empty-dirs --log-file="/root/rlog" --delete-after ${mainsource} ${localmain}
  else
    # the process IS running
    # handle it
    echo this process is running
    exit 0
  fi
else
  echo $$ > "${LCK_FILE}"
fi
