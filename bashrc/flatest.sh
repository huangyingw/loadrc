#!/bin/bash
find $1 -type f -mtime -100 -exec ls -lrt {} \+;
#find $1 -type f -exec ls -lrt {} \+;
