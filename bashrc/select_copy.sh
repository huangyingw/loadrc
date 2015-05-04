#!/bin/bash
find /home/huangyingw/cvs/ -type f -name \*.properties | while read ss;
do
  echo $ss|sed -n "s/[^\/]*.properties$//p"
done

