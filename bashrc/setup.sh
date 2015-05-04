#!/bin/bash
APPLIST=$HOME/bashrc/app_list
app_list=();
while read suf
do
  app_list+=("$suf")
done < "$APPLIST"
apt-get install "${app_list[@]}" --force-yes -y
