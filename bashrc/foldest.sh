#!/bin/bash
find $1 -type f -exec ls -lt {} \+;
#find $1 -type f -exec ls -lrt {} \+;
