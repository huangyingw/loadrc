#!/bin/bash
echo "$1"
if [ -z "$1" ];
then
  git add .
else
  git add $1
fi
