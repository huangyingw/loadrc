#!/bin/bash -
git bisect reset
BADCOMMIT=$(cat gbil.findresult | awk '/first bad commit/{print $5}' | sed  -e "s/\(\[\|\]\)//g;s/^\(.\{8\}\).*/\1/")
echo "first bad commit --> $BADCOMMIT"
~/loadrc/gitrc/gcob.sh "$BADCOMMIT.fix" "$BADCOMMIT^" 
