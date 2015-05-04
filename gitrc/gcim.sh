#!/bin/bash
git commit -m "`cat .git/MERGE_MSG |awk 'NR==1'`"
