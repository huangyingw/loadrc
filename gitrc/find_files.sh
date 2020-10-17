#!/bin/zsh
my_array=()

while IFS= read -r line; do
    my_array+=( "$line" )
done < <( grep  -i $1 files.proj | sed -e 's/"//g' )

output="$(echo "$1" | sed 's/\//_/g;s/ //g').findresult"

if [ ${#my_array[@]} -eq 1 ]; then
    printf "%s\n" "${my_array[@]}"
else
    printf "%s\n" "${my_array[@]}" > "$output"
    echo "$output"
fi
