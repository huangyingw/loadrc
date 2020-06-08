#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide the target file name... ${NC}"
    exit 1
fi

targetFile="$1"
SCRIPT=$(realpath "$targetFile")

# check to see if script is already running
PDIR=${0%`basename $0`}
LCK_FILE="$(basename -- "$SCRIPT" | cut -d. -f1).lck"

if [ -f "${LCK_FILE}" ]
then
    MYPID=`head -n 1 "${LCK_FILE}"`

    echo "I am waitting for pid --> $MYPID"
    ~/loadrc/bashrc/wait_for_pid.sh "$MYPID"
    echo "I am running, pid --> $$"
    echo $$ > "${LCK_FILE}"
    "$SCRIPT"
else
    echo $$ > "${LCK_FILE}"
fi
