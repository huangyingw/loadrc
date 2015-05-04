#!/bin/bash
find "$1" \( -name \.svn -o -name \.git -o -name \.hg \) -prune -o -mmin -5 -print
