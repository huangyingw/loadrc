#!/bin/bash
docker stop docker-jetty
docker rm docker-jetty
SCRIPT_DIR=$(dirname $0)
docker run  \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/mybase/:/opt/web/mybase/ \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/jetty/:/opt/jetty/ \
  --env-file $SCRIPT_DIR/env.list \
  -h docker-jetty \
  --name docker-jetty \
  -p 80:8080 \
  -p 443:8443 \
  -d docker-jetty
