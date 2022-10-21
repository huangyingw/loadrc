#!/bin/zsh

if (df -P . | sed -n '$s/[[:blank:]].*//p' | grep -q ':')
then
    return 0
else
    return 1
fi
