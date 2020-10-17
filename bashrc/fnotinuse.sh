#!/bin/zsh
find_result=fnotinuse.findresult
echo > "$find_result"
cscope_db_file="/export/home1/username/cscope_db/""${pwd##*/}"
while read fullfile
do
    filename=$(basename "$fullfile")
    filename="${filename%.*}"
    if [ $(xargs fgrep -wnH "$filename" < "$cscope_db_file" |wc -l) -eq 0 ]
    then
        echo "$fullfile" >> "$find_result"
    fi
done < '/export/home1/username/cscope_db/'`pwd |sed -e "s/^.*\///g"`
