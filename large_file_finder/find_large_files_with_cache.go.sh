#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

go mod init github.com/huangyingw/FileSorter
go get -u github.com/allegro/bigcache
go get -u github.com/go-redis/redis/v8
docker run --name my-redis -d -p 6379:6379 redis

go build find_large_files_with_cache.go && \
    ./find_large_files_with_cache /media/115_disk/av/kyler/
