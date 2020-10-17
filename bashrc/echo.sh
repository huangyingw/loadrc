#!/bin/zsh
LCK_FILE="echo.lck"
MYPID=`head -n 1 "${LCK_FILE}"`
while true
do
    echo "I am running, pid --> $MYPID"
done
