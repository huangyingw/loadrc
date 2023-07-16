#!/bin/zsh

function main() {
    FAVLOG="fav.log.tmp"
    FAVLOGSORT="fav.log.sort.tmp"
    export LC_ALL=C
    EXCLUDE_FILE="exclude_patterns.txt"

    if [ -n "$2" ]
    then
        SIZE_OPTION="+${2}M"
    else
        SIZE_OPTION="+10M"
    fi

    cd "$1"
    echo "SIZE_OPTION --> $SIZE_OPTION"

    # Build the find command with exclusion patterns from the EXCLUDE_FILE
    find_cmd="find . -type f -size \"${SIZE_OPTION}\""

    # If the exclude file exists, then process it
    if [ -f "${EXCLUDE_FILE}" ]
    then
        while IFS= read -r line
        do
            find_cmd+=" ! -path \"${line}\""
        done < "${EXCLUDE_FILE}"
    fi

    eval "${find_cmd} -exec du -h {} + | sort -r -h | cut -f 2 | sed 's/\([\"\\]\)/\\\1/g;s/.*/\"&\"/' > \"${FAVLOG}\"" && \
        cp -fv "${FAVLOG}" fav.log && \
        eval "${find_cmd} -exec ls -t {} + | sed 's/\([\"\\]\)/\\\1/g;s/.*/\"&\"/' > \"${FAVLOGSORT}\"" && \
        cp -fv "${FAVLOGSORT}" fav.log.sort

    cd -
}

main "$1" "$2"
