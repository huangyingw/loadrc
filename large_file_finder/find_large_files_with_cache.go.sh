#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

go mod init github.com/huangyingw/FileSorter
go get -u github.com/allegro/bigcache
go get -u github.com/go-redis/redis/v8
go get -u github.com/mattn/go-zglob/fastwalk
go get -u github.com/karrick/godirwalk

docker-compose down -v && docker-compose up -d

#go build find_large_files_with_cache.go && \
#    sudo ./find_large_files_with_cache /media/usb_backup_crypt_5T_1

go build find_large_files_with_cache.go && \
    sudo ./find_large_files_with_cache /media
