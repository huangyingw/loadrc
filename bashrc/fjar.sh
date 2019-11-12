#!/bin/bash
LOOK_FOR="$2"

for i in `find "$1" -name "*jar"`
do
  echo "Looking in $i ..."
  jar tvf $i | grep $LOOK_FOR > /dev/null
  if [ $? == 0 ]
  then
    echo "==> Found \"$LOOK_FOR\" in $i"
  fi
done
