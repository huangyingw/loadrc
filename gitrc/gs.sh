#!/bin/bash
if [ -n "$1" ];
then
  git status "$1" 2>&1 | tee -a gs.findresult
else
  git status 2>&1 | tee -a gs.findresult
fi
vi gs.findresult
