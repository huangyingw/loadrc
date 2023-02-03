#!/bin/zsh
find . | xargs grep -l email@domain.com | awk '{print "rm "$1}' > doit.sh
