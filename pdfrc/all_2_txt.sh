#!/bin/zsh

find . -type f -iname \*.pdf | while read ss
do
    pdftotext "$ss" "$(echo "$ss" | sed 's/\.pdf/\.txt/g')"
done
