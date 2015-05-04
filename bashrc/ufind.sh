#!/bin/bash
function Find()
{
  FILE_POSTFIX=$HOME/bashrc/postfix
  PRUNE_POSTFIX=$HOME/bashrc/prunefix
  PRUNE_FILE=$HOME/bashrc/prunefile
  find_params=();
  prune_params=();
  prune_files=();
  find_result="$2".findresult
  or="";
  grep_params="";
  if [ -n "$3" ]
  then grep_params=" -A"$3" -B"$3;
  fi
  while read suf
  do
    find_params+=( $or "-iname" "*.$suf" )
    or="-o"
  done < "$FILE_POSTFIX"
  or="";
  while read suf
  do
    prune_params+=( $or "-iname" "*.$suf" )
    or="-o"
  done < "$PRUNE_POSTFIX"
  while read suf
  do
    prune_files+=( $or "-iname" "$suf" )
    or="-o"
  done < "$PRUNE_FILE"
  find "$1" "(" "${prune_params[@]}" "${prune_files[@]}" "-o" "-iname" "$find_result" ")" -prune -o "(" "${find_params[@]}" "-o" "-iname" "makefile" ")" -exec fgrep -inH  $grep_params "$2" {} \; > "$find_result"
}

ls *.findresult|while read ss; do echo $ss|sed 's/.findresult//g'; done \
  |while read ss;do Find "." "$ss" && echo "$ss" is done;done
