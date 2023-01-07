#! /bin/zsh

FAVLOG="fav.log.tmp"
FAVLOGSORT="fav.log.sort.tmp"
export LC_ALL=C

if [ -n "$2" ]
then
    SIZE_OPTION="+$2M"
else
    SIZE_OPTION="+10M"
fi

cd "$1"
echo "SIZE_OPTION --> $SIZE_OPTION"
find . -type f -size "$SIZE_OPTION" -exec du -h {} + | sort -r -h | cut -f 2 | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > "$FAVLOG" && \
    cp -fv "$FAVLOG" fav.log && \
    find . -type f -size "$SIZE_OPTION" -exec ls -t {} \+ | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > "$FAVLOGSORT" && \
    cp -fv "$FAVLOGSORT" fav.log.sort

cd -
