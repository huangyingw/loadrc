#!/bin/bash
if [ ${PWD##*/} == ".git" ]
then
    cd ../
fi

git reset --hard $1
