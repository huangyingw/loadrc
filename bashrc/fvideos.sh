#! /bin/zsh

find . -type f -size +10M -exec du -h {} + | sort -r -h | cut -f 2 > fav.log.bak && \
    cp -fv fav.log.bak fav.log && \
    find . -type f -size +10M -exec ls -t {} \+ > fav.log.sort.bak && \
    cp -fv fav.log.sort.bak fav.log.sort
