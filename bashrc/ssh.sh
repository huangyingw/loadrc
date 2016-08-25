#! /bin/bash
ssh -X "$1" -t -- ${tmuxAction}
