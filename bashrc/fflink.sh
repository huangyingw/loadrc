#!/bin/bash
[ $# -eq 0 ]&&directorys=`pwd`||directorys=$@
linkchk()
{
    for file in $1/*
    do
        #       echo "$file"
        [ -L "$file" -a ! -e "$file" ]&& ls -l $file | awk '{for(i=9;i<=19;i++) printf $i""FS;print ""}'
        # 这里的-a是and的意思就是-L "$file"和 -e "$file" 都成立的意思
        [ -d "$file" ]&&linkchk $file
    done
}
for directory in $directorys
do
    if [ -d $directory ]
    then linkchk $directory
    else
        echo "$directory is not a directory"
        echo "Usage:$0 dir1 dir2 ..."
    fi
done
exit 0
