#!/bin/bash
if [ -z "$1" ];
then
  echo -e "${red}Please provide the new branch name ... ${NC}"
  exit 1
fi
if [ -n "$2" ];
then
  git checkout -b "$1" "$2"
else
  git checkout -b "$1"
fi
