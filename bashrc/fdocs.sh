#! /bin/zsh

DocConfig="fdocs.config"
TARGET="fdocs.list"

if [ -f "$DocConfig" ]
then
    or="";

    while read suf
    do
        suf=$(echo "$suf" | sed 's/"//g')
        include_params+=( $or "-wholename" "$suf" )
        or="-o"
    done < "$DocConfig"

    find . "(" "${include_params[@]}" ")" -type f -print | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > "$TARGET"
    sort -u "$TARGET" -o "$TARGET"
fi
