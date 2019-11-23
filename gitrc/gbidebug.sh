#!/bin/zsh
git bisect reset
BADCOMMIT=$(cat gbil.log | awk '/first bad commit/{print $5}' | sed  -e "s/\(\[\|\]\)//g;s/^\(.\{8\}\).*/\1/")
echo "first bad commit --> $BADCOMMIT"
git branch -d "$BADCOMMIT.fix"
~/loadrc/gitrc/gcob.sh "$BADCOMMIT.fix" "$BADCOMMIT^"
