#! /bin/zsh

FAVLOG="fav.log.tmp"
FAVLOGSORT="fav.log.sort.tmp"
export LC_ALL=C
find . -type f -size +500k -exec ls -S {} \+ | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > "$FAVLOG" && \
    cp -fv "$FAVLOG" fav.log && \
    find . -type f -size +500k -exec ls -t {} \+ | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > "$FAVLOGSORT" && \
    cp -fv "$FAVLOGSORT" fav.log.sort
