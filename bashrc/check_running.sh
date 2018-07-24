#! /bin/bash

# check to see if script is already running
PDIR=${0%`basename $0`}
LCK_FILE=`basename $0`.lck

if [ -f "${LCK_FILE}" ]
then
    MYPID=`head -n 1 "${LCK_FILE}"`

    TEST_RUNNING=`ps -p ${MYPID} | grep ${MYPID}`

    if [ -z "${TEST_RUNNING}" ]
    then
        # The process is not running
        # Echo current PID into lock file
        echo $$ > "${LCK_FILE}"
        ./submission.sh
    else
        # the process IS running
        # handle it
        exit 1
    fi
else
    echo $$ > "${LCK_FILE}"
fi
