#!/bin/zsh
programDir=~/bin/Umlet

if [ $# -eq 1 ]
 then java -jar ${programDir}/umlet.jar -filename="$1"
 else java -jar ${programDir}/umlet.jar "$@"
fi
