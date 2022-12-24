#! /bin/zsh

FAVLOG="fav.log.tmp"
FAVLOGSORT="fav.log.sort.tmp"
export LC_ALL=C

cd "$1"
find . -type f -size +100M -exec du -h {} + | sort -r -h | cut -f 2 | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > "$FAVLOG" && \
    cp -fv "$FAVLOG" fav.log && \
    find . -type f -size +100M -exec ls -t {} \+ | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > "$FAVLOGSORT" && \
    cp -fv "$FAVLOGSORT" fav.log.sort

cd -
