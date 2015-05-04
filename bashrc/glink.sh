#!/bin/bash
real_dir=`ls -l "$1"|awk '{print $11}'`
cd "$real_dir"
