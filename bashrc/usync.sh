#! /bin/zsh
TARGET=exp
if [ -n "$1" ]
then
  TARGET="$1"
fi
echo $TARGET
UBAKEX="$HOME/loadrc/bashrc/usync_ex"
UBAKIN="$HOME/loadrc/bashrc/usync_in"
exclude_params=();
while read suf
do
    exclude_params+=( "--exclude=$suf" )
done < "$UBAKEX"
include_params=();
while read suf
do
    include_params+=( "--include=$suf" )
done < "$UBAKIN"
rsync -aH --force -e ssh "${exclude_params[@]}" "${include_params[@]}" /home/huangyingw/ "${TARGET}":/home/huangyingw/
rsync -aH --force -e ssh "${exclude_params[@]}" "${include_params[@]}" /root/ "${TARGET}":/root/
