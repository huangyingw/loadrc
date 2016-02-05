#!/bin/bash
SCRIPT_DIR=$(dirname $0)
docker run  \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/service/:/root/service/ \
  --env-file $SCRIPT_DIR/env.list \
  -h kurento \
  -p 8888:8888 \
  -p 8089:8089 \
  -ti java
