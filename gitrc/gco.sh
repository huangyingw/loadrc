#!/bin/bash
git branch \
  |awk '/^\*/{print $2}' \
  && git checkout "$1"
