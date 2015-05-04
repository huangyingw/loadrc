#!/bin/bash
if [ -z "$1" ];
then
  find . -type f -exec du -sk {} \; | sort -n
else
  find $1 -type f -exec du -sk {} \; | sort -n
fi
