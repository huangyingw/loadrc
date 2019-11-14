#!/bin/bash - 
retn_value=$(~/loadrc/gitrc/git_ready.sh)

if [ "$retn_value" ] 
then
    echo true
else
    echo false
fi
