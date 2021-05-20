#!/bin/zsh

GITK=$(realpath $(which gitk))
sed -i.bak 's/set ignorespace 0/set ignorespace 1/g' "$GITK"  
