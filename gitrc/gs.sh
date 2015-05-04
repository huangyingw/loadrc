#!/bin/bash
if [ -n "$1" ];
then
  git status "$1" > gs.findresult
else
  git status > gs.findresult 
fi
vi gs.findresult
