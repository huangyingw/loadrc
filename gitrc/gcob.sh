#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
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
