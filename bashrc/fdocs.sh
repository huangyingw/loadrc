#! /bin/zsh

FdocsInclude="fdocs.include"
FdocsExclude="fdocs.exclude"
TARGET="fdocs.list"

if [ -f "$FdocsInclude" ]
then
    or="";

    while read suf
    do
        suf=$(echo "$suf" | sed 's/"//g')
        include_params+=( $or "-wholename" "$suf" )
        or="-o"
    done < "$FdocsInclude"

    or="";

    while read suf
    do
        suf=$(echo "$suf" | sed 's/"//g')
        exclude_params+=( $or "-wholename" "$suf" )
        or="-o"
    done < "$FdocsExclude"

    find . "(" "${exclude_params[@]}" ")" -a -prune -o "(" "${include_params[@]}" ")" -type f -print | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > "$TARGET" 
    sort -u "$TARGET" -o "$TARGET"
fi
