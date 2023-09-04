#!/bin/zsh

function main() {
    FAVLOG="fav.log.tmp"
    FAVLOGSORT="fav.log.sort.tmp"
    export LC_ALL=C
    EXCLUDE_FILE="exclude_patterns.txt"

    SIZE_OPTION="${2:-200}"
    BYTE_SIZE_OPTION=$((SIZE_OPTION * 1024 * 1024))

    cd "$1" || exit
    echo "SIZE_OPTION --> $SIZE_OPTION M"
    echo "BYTE_SIZE_OPTION --> $BYTE_SIZE_OPTION bytes"

    # Build the find command with exclusion patterns from the EXCLUDE_FILE
    find_cmd="find . -type f -size +${SIZE_OPTION}M"

    # If the exclude file exists, then process it
    if [ -f "${EXCLUDE_FILE}" ]
    then
        while IFS= read -r line
        do
            find_cmd+=" ! -path \"${line}\""
        done < "${EXCLUDE_FILE}"
    fi

    echo "find_cmd --> $find_cmd"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        eval "${find_cmd} -exec du -k {} + | sort -rn | cut -f 2- | sed 's/\([\"\\]\)/\\\1/g;s/.*/\"&\"/' > \"${FAVLOG}\""
        cp -fv "${FAVLOG}" fav.log
        eval "${find_cmd} -exec stat -f '%m %N' {} \; | sort -rn | cut -d' ' -f2- | sed 's/\([\"\\]\)/\\\1/g;s/.*/\"&\"/' > \"${FAVLOGSORT}\""
        cp -fv "${FAVLOGSORT}" fav.log.sort
    else
        # Linux
        eval "${find_cmd} -printf '%T+ %p\\n' | sort -r | cut -d' ' -f2- | sed 's/\([\"\\]\)/\\\1/g;s/.*/\"&\"/' > \"${FAVLOGSORT}\""
        cp -fv "${FAVLOGSORT}" fav.log.sort
        eval "${find_cmd} -exec sh -c 'du -b \"{}\" | awk \"{if (\\\$1 > $BYTE_SIZE_OPTION) {size=\\\$1; \\\$1=\\\"\\\"; gsub(/^ /, \\\"\\\", \\\$0); print size\\\",\\\\\\\"'\"{}\"'\\\\\\\"\\\"}}\"' \; | sort -rn > \"${FAVLOG}\""
        cp -fv "${FAVLOG}" fav.log
    fi

    cd -
}

main "$1" "$2"
