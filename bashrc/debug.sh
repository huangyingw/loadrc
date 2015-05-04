#! /bin/bash
if [ -z "$1" ];
then
  valgrind -v --log-file=vlog --leak-check=full ./*.exe
else
  valgrind -v --log-file=vlog --leak-check=full ./$1
fi
