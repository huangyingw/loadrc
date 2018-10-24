#!/bin/bash -
my_array=()

while IFS= read -r line; do
    my_array+=( "$line" )
done < <( grep  $1 files.proj | sed -e 's/"//g' )

if [ ${#my_array[@]} -eq 1 ]; then
    echo ${my_array[0]}
else
    printf "%s\n" "${my_array[@]}" > find_files.findresult
    echo "find_files.findresult"
fi
