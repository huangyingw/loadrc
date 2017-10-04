#!/bin/bash
if [ -z "$1" ]
then
    ssh server pm-suspend
fi
ssh "$1" pm-suspend
