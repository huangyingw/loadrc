#!/bin/bash
if [ -z "$1" ]
then
    ssh movie pm-suspend
fi
ssh "$1" pm-suspend
