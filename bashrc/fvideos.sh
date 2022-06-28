#! /bin/zsh

echo  /Users/huangyingw/loadrc/bashrc/fvideos.sh >> ~/loadrc/debug.runresult
FAVLOG="fav.log.tmp"
FAVLOGSORT="fav.log.sort.tmp"
export LC_ALL=C
find . -type f -size +500k -exec du -h {} + | sort -r -h | cut -f 2 | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > "$FAVLOG" && \
    cp -fv "$FAVLOG" fav.log && \
    find . -type f -size +500k -exec ls -t {} \+ | sed 's/\(["\]\)/\\\1/g;s/.*/"&"/' > "$FAVLOGSORT" && \
    cp -fv "$FAVLOGSORT" fav.log.sort
