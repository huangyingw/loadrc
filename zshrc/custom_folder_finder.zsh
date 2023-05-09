#!/bin/zsh

# custom_folder_finder.zsh
# A script to find a folder with a given name (case sensitive, exact match, and full word match) in a specified directory.
# It sorts the output by length and for the same length, it sorts by size (bigger first).

search_folder() {
    find "$1" -type d -name "$2" -maxdepth "$3" 2>/dev/null
}

sort_results() {
    while read -r line; do
        folder_size=$(du -sb "$line" | awk '{print $1}')
        folder_length=$(echo -n "$line" | wc -m | tr -d '[:space:]')
        echo -e "$folder_length\t$folder_size\t$line"
    done | sort -k1,1n -k2,2nr | awk '{print $3}'
}

main() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: $0 search_directory folder_name [maxdepth]"
        exit 1
    fi

    search_directory="$1"
    folder_name="$2"
    maxdepth="${3:-5}"
    search_folder "$search_directory" "$folder_name" "$maxdepth" | sort_results
}

search_directory="$1"
folder_name="$2"
maxdepth="${3:-5}"
main "$search_directory" "$folder_name" "$maxdepth"
