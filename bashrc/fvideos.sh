#! /bin/zsh

find . -type f -size +500k -exec du -h {} + | sort -r -h | cut -f 2 | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > fav.log.bak ; \
    cp -fv fav.log.bak fav.log && \
    find . -type f -size +500k -exec ls -t {} \+ | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > fav.log.sort.bak ; \
    cp -fv fav.log.sort.bak fav.log.sort
