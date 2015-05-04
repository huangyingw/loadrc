#!/bin/bash 
TARGET=thinkpad
if [ -n "$1" ]
then 
  TARGET="$1"
fi
echo $TARGET
NETSYNC="$HOME/bashrc/netsync_ex"
exclude_params=();
while read suf
do
  exclude_params+=( "--exclude=$suf" )
done < "$NETSYNC"
rsync -e ssh -aH --delete-during "${exclude_params[@]}" / "${TARGET}":/ \
  && rsync -e ssh -aH --delete-during /home/huangyingw/Dropbox/ "${TARGET}":/home/huangyingw/Dropbox/ \
  && rsync -e ssh -aH --delete-during /home/huangyingw/.mozilla/ "${TARGET}":/home/huangyingw/.mozilla/ \
  && ssh "${TARGET}" pm-suspend
